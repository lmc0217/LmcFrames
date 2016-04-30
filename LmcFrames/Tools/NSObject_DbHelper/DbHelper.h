//
//  DbHelper.h
//  
//
//  Created on 12-12-15.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+Property.h"
//#import "FMDatabase.h"
//#import "FMDatabaseQueue.h"

@interface DbHelper : NSObject
{
    FMDatabase* _db;
    FMDatabaseQueue* _dbQueue;
}
 
+(DbHelper *)instance;
-(FMDatabaseQueue *)queue;
-(FMDatabase *)db;
-(BOOL)isExistsTable:(NSString *)tablename;
-(BOOL)DropExistsTable:(NSString*)tableName;
-(BOOL)createTableByClassName:(NSString *)classname;
-(BOOL)createTableByClass:(Class)clazz;
-(void)insert:(Class)clazz dict:(NSDictionary *)dict;
-(NSString *)createInsertSqlByClass:(Class)clazz;
-(NSString *)createInsertSqlByDictionary:(NSDictionary *)dict tablename:(NSString *)table;
-(void)insertBySql:(NSString *)sql dict:(NSDictionary *)dict;
-(void)insertObject:(id)object;
-(void)executeByQueue:(NSString *)sql;

//查询数据到字典数组，字典的Key对应列名
-(NSArray *)queryDbToDictionaryArray:(NSString *)tablename;
-(NSArray *)queryDbToDictionaryArray:(NSString *)tablename sql:(NSString *)sql;

//查询数据到对象数组，数据多时考虑效率问题，另注意列名与对象属性之间的对应关系
-(NSArray *)queryDbToObjectArray:(Class )clazz sql:(NSString *)sql;
-(NSArray *)queryDbToObjectArray:(Class )clazz;
@end
