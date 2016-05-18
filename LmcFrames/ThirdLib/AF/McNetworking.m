//
//  McNetworking.m
//  LmcFrames
//
//  Created by lmc on 16/5/18.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "McNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

typedef NS_ENUM(NSInteger,httpMethod){
    
    /** GET */
    httpMethod_get =1,
    
    /** POST */
    httpMethod_post,
    /** PUT */
    httpMethod_put
};

static NSString *_NetworkBaseUrl = nil;
static NSMutableArray *_requestTasks;
static NSDictionary *_httpHeaders = nil;
@implementation McNetworking

+ (void)setBaseUrl:(NSString *)baseUrl
{
    _NetworkBaseUrl = baseUrl;
}
+ (NSString *)baseUrl
{
    return _NetworkBaseUrl;
}

+ (void)configHttpHeaders:(NSDictionary *)httpHeaders
{
    _httpHeaders = httpHeaders;
}
+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_requestTasks == nil) {
            _requestTasks = [[NSMutableArray alloc] init];
        }
    });
    
    return _requestTasks;
}

/*
 *  GET请求接口，若不指定baseurl，可传完整的url
 */
+ (McURLSessionTask *)getWithUrl:(NSString *)url
                         success:(McResponseSuccess)success
                            fail:(McResponseFail)fail
{
    return [self getWithUrl:url params:nil success:success fail:fail];
}

+ (McURLSessionTask *)getWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(McResponseSuccess)success
                            fail:(McResponseFail)fail
{
    return [self getWithUrl:url params:params progress:nil success:success fail:fail];
}

+ (McURLSessionTask *)getWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                        progress:(McGetProgress)progress
                         success:(McResponseSuccess)success
                            fail:(McResponseFail)fail
{
    return [self requestWithUrl:url
                      httpMedth:httpMethod_get
                         params:params
                       progress:progress
                        success:success
                           fail:fail];
}

/*
 *  POST请求接口，若不指定baseurl，可传完整的url
 */
+ (McURLSessionTask *)postWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                          success:(McResponseSuccess)success
                             fail:(McResponseFail)fail
{
    return [self postWithUrl:url params:params progress:nil success:success fail:fail];
}
+ (McURLSessionTask *)postWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                         progress:(McPostProgress)progress
                          success:(McResponseSuccess)success
                             fail:(McResponseFail)fail
{
    return [self requestWithUrl:url
                      httpMedth:httpMethod_post
                         params:params
                       progress:progress
                        success:success
                           fail:fail];
}
#pragma mark - 请求方法
+ (McURLSessionTask *)requestWithUrl:(NSString *)url
                             httpMedth:(httpMethod)httpMethod
                                params:(NSDictionary *)params
                              progress:(McDownloadProgress)progress
                               success:(McResponseSuccess)success
                                  fail:(McResponseFail)fail
{
    AFHTTPSessionManager *manager = [self manager];
    NSString *absolute = [self absoluteUrlWithPath:url];
    
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        NSURL *absouluteURL = [NSURL URLWithString:absolute];
        
        if (absouluteURL == nil) {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    McURLSessionTask *sessionTask = nil;
    
    if (httpMethod == httpMethod_get) {
        //GET请求
        sessionTask = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponse:responseObject callback:success];
            //任务数组中移除task
            [[self allTasks] removeObject:task];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail(error);
            [[self allTasks] removeObject:task];
        }];
    }
    else if (httpMethod == httpMethod_post)
    {
        //POST请求
        sessionTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponse:responseObject callback:success];
            [[self allTasks] removeObject:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail(error);
            [[self allTasks] removeObject:task];
        }];
    }
    if (sessionTask) {
        [[self allTasks] addObject:sessionTask];
    }
    return sessionTask;
}

+ (NSString *)absoluteUrlWithPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        return @"";
    }
    
    if ([self baseUrl] == nil || [[self baseUrl] length] == 0) {
        return path;
    }
    
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {
        if ([[self baseUrl] hasSuffix:@"/"]) {
            if ([path hasPrefix:@"/"]) {
                NSMutableString * mutablePath = [NSMutableString stringWithString:path];
                [mutablePath deleteCharactersInRange:NSMakeRange(0, 1)];
                absoluteUrl = [NSString stringWithFormat:@"%@%@",
                               [self baseUrl], mutablePath];
            }else {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            }
        }else {
            if ([path hasPrefix:@"/"]) {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            }else {
                absoluteUrl = [NSString stringWithFormat:@"%@/%@",
                               [self baseUrl], path];
            }
        }
    }
    
    return absoluteUrl;
}

+ (id)tryToParseData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        // 尝试解析成JSON
        if (responseData == nil) {
            return responseData;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
            
            if (error != nil) {
                return responseData;
            } else {
                return response;
            }
        }
    } else {
        return responseData;
    }
}
+ (void)successResponse:(id)responseData callback:(McResponseSuccess)success {
    if (success) {
        success([self tryToParseData:responseData]);
    }
}
#pragma mark - Private
+ (AFHTTPSessionManager *)manager {
    // 开启转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = nil;;
    if ([self baseUrl] != nil) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
    } else {
        manager = [AFHTTPSessionManager manager];
    }
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    for (NSString *key in _httpHeaders.allKeys) {
        if (_httpHeaders[key] != nil) {
            [manager.requestSerializer setValue:_httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    
//    manager.requestSerializer.timeoutInterval = sg_timeout;
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
//    if (sg_shoulObtainLocalWhenUnconnected && (sg_cacheGet || sg_cachePost ) ) {
//        [self detectNetwork];
//    }
    return manager;
}

+ (void)cancelAllRequest {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(McURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[McURLSessionTask class]]) {
                [task cancel];
            }
        }];
        
        [[self allTasks] removeAllObjects];
    };
}

+ (void)cancelRequestWithURL:(NSString *)url {
    if (url == nil) {
        return;
    }
    
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(McURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[McURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}

@end
