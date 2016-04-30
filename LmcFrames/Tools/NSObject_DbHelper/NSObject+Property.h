//
//  NSObject+Property.h
//   
//
//  Created on 12-12-15.
//
//
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@interface NSObject (Property)
- (NSArray *)getPropertyList;
- (NSArray *)getPropertyList: (Class)clazz;
- (NSString *)tableSql:(NSString *)tablename;
- (NSString *)tableSql;
- (NSDictionary *)convertDictionary;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSString *)className;
@end
