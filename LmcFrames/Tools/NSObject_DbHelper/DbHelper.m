//
//  DbHelper.m
//  
//
//  Created on 12-12-15.
//
//

#import "DbHelper.h"

@implementation DbHelper
 
+(DbHelper *)instance{
    static DbHelper *db  ;
    
    @synchronized(self) {
        if(!db) {
            db = [[DbHelper alloc] init];
            
        }
    }
    return db;
}

-(id)init{
    self = [super init];
    if(self){
        NSString *dbpath = [kAppDelegate.temporaryValues objectForKey:@"dbPath"];
        NSLog(@"db path:%@",dbpath);
        _db = [FMDatabase databaseWithPath:dbpath];
        [_db setLogsErrors:YES];
        [_db open];
       _dbQueue =   [FMDatabaseQueue databaseQueueWithPath:dbpath];
    }
    return self;
}
-(FMDatabaseQueue *)queue{
    return _dbQueue;
}

-(FMDatabase *)db{
   return _db;
}
-(void)executeByQueue:(NSString *)sql{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql];
    }];
}
-(BOOL)isExistsTable:(NSString *)tablename{
    FMResultSet *rs = [_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tablename];
    BOOL ret = NO;
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        //  NSLog(@"isTableOK %d", count);
        
        if (0 == count)
        {
            ret = NO;
        }
        else
        {
            ret = YES;
        }
    }
    return ret;
}
//drop exists table
-(BOOL)DropExistsTable:(NSString*)tableName{
    if ([self isExistsTable:tableName]) {
        NSString *sql = [NSString stringWithFormat:@"drop table %@",tableName];
        BOOL ret = [_db executeUpdate:sql];
        return ret;
    }
    return YES;
}
-(BOOL)createTableByClass:(Class)clazz{
   NSString *classname = [NSString  stringWithUTF8String:class_getName(clazz)];
    return [self createTableByClassName:classname];
}
-(BOOL)createTableByClassName:(NSString *)classname{
    if ([self isExistsTable:classname]) {
        return YES;
    }
   id obj = [[NSClassFromString(classname) alloc] init];
    if (obj==nil) {
        return NO;
    }
    NSString *sql = [obj tableSql];
    BOOL ret = [_db executeUpdate:sql];
    return ret;
}
-(void)insert:(Class)clazz dict:(NSDictionary *)dict{
    
    //create table
    
    NSString *sql = [self createInsertSqlByClass:clazz ];
    return [self insertBySql:sql dict:dict];
}

-(void)insertObject:(id)object{
    NSString *tablename = [object className];
    NSMutableString *sql = [[NSMutableString alloc] init];
    NSArray *array = [object getPropertyList];
    [sql appendFormat:@"insert into %@ (",tablename] ;
    NSInteger i = 0;
    for (NSString *key in array) {
        if (i>0) {
            [sql appendString:@","];
        }
        [sql appendFormat:@"%@",key];
        i++;
    }
    [sql appendString:@") values ("];
    NSMutableArray *arrayValue = [NSMutableArray array];
    i=0;
    for (NSString *key in array) {
        SEL selector = NSSelectorFromString(key);
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id value = [object performSelector:selector];
#pragma clang diagnostic pop
        
 
        if (value==nil) {
            value = @"";
        }
        [arrayValue addObject:value];
        if (i>0) {
            [sql appendString:@","];
        }
        [sql appendString:@"?"];
        i++;
    }
    [sql appendString:@")"];
    [_db executeUpdate:sql withArgumentsInArray:arrayValue];
}


-(void)insertBySql:(NSString *)sql dict:(NSDictionary *)dict{
    if (sql && sql.length>0) {
        [_dbQueue inDatabase:^(FMDatabase *db) {
            [db executeUpdate:sql withParameterDictionary:dict];
        }];
    }
}
-(NSString *)createInsertSqlByDictionary:(NSDictionary *)dict tablename:(NSString *)table{
    
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendFormat:@"insert into %@ (",table] ;
    NSInteger i = 0;
    for (NSString *key in dict.allKeys) {
        if (i>0) {
            [sql appendString:@","];
        }
        [sql appendFormat:@"%@",key];
        i++;
    }
    [sql appendString:@") values ("];
    i = 0;
    for (NSString *key in dict.allKeys) {
        if (i>0) {
            [sql appendString:@","];
        }
        [sql appendFormat:@":%@",key];
        i++;
    }
    [sql appendString:@")"];
    return sql;
}
-(NSString *)createInsertSqlByClass:(Class)clazz{
    id obj = [[clazz alloc] init];
    if (obj==nil) {
        return nil;
    }
    NSString *classname = [NSString  stringWithUTF8String:class_getName(clazz)];
    
    NSMutableString *sql = [[NSMutableString alloc] init];
    NSArray *array = [obj getPropertyList];
    [sql appendFormat:@"insert into %@ (",classname] ;
    NSInteger i = 0;
    for (NSString *key in array) {
        if (i>0) {
            [sql appendString:@","];
        }
        [sql appendFormat:@"%@",key];
        i++;
    }
    [sql appendString:@") values ("];
    i = 0;
    for (NSString *key in array) {
        if (i>0) {
            [sql appendString:@","];
        }
        [sql appendFormat:@":%@",key];
        i++;
    }
    [sql appendString:@")"];
    return sql;
}

-(NSArray *)queryDbToDictionaryArray:(NSString *)tablename{
    //http://www.byysoo.com/a/webqianduan/2012/0322/30377.html
    //TDB
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tablename];
    return [self queryDbToDictionaryArray:tablename sql:sql];
}
-(NSArray *)fMSetColumnArray:(FMResultSet *)fmset{
    FMStatement *statement = fmset.statement;
    NSInteger columnCount = sqlite3_column_count(statement.statement);
    NSMutableArray *columnArray = [NSMutableArray array];
    
    for (NSInteger columnIdx = 0; columnIdx < columnCount; columnIdx++) {
        NSString *columnName = [NSString stringWithUTF8String:sqlite3_column_name(statement.statement, columnIdx)];
        [columnArray addObject:columnName];
    }
    return columnArray;
}
 
-(NSArray *)queryDbToDictionaryArray:(NSString *)tablename sql:(NSString *)sql{
    FMResultSet *resultSet=[_db executeQuery:sql];
    NSArray *columnArray = [self  fMSetColumnArray:resultSet];
    NSMutableArray *syncArray = [[NSMutableArray alloc] init];
    NSString *columnName = nil;
    while ([resultSet next])
    {
        NSMutableDictionary *syncData = [[NSMutableDictionary alloc] init];
        for(int i =0;i<columnArray.count;i++)
        {
            columnName = [columnArray objectAtIndex:i];
            NSString *columnValue = [resultSet stringForColumn: columnName];
            if (columnValue==nil) {
                columnValue=@"";
            }
            [syncData setObject:columnValue forKey:columnName];
        }
        [syncArray addObject:syncData];
    }
    if ([syncArray count]==0) {
        return nil;
    }
    
    return syncArray;
}
-(NSArray *)queryDbToObjectArray:(Class )clazz sql:(NSString *)sql{
    FMResultSet *resultSet=[_db executeQuery:sql];
    NSArray *columnArray = [self  fMSetColumnArray:resultSet];
    NSMutableArray *syncArray = [[NSMutableArray alloc] init];
    NSString *columnName = nil;
    while ([resultSet next])
    {
        NSObject *obj = [[clazz alloc] init];
        
        if (obj==nil) {
            continue;
        }
        
        for(int i =0;i<columnArray.count;i++)
        {
            columnName = [columnArray objectAtIndex:i];
            NSString *columnValue = [resultSet stringForColumn: columnName];
            SEL selector = NSSelectorFromString(columnName);
            
            if ([obj respondsToSelector:selector]) {
                [obj setValue:columnValue forKeyPath:columnName ];
            }
        }
        [syncArray addObject:obj];
    }
    if ([syncArray count]==0) {
        return nil;
    }
    return syncArray;
}
-(NSArray *)queryDbToObjectArray:(Class )clazz{
    NSString *classname = [NSString  stringWithUTF8String:class_getName(clazz)];
    NSString *sql = [NSString stringWithFormat:@"select * from %@",classname];
    return [self queryDbToObjectArray:clazz sql:sql];
    
}
@end
