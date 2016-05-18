//
//  McNetworking.h
//  LmcFrames
//
//  Created by lmc on 16/5/18.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSURLSessionTask;
/*!
 *
 *  下载进度
 *
 *  @param bytesRead                 已下载的大小
 *  @param totalBytesRead            文件总大小
 *  @param totalBytesExpectedToRead 还有多少需要下载
 */
typedef void (^McDownloadProgress)(int64_t bytesRead,
                                    int64_t totalBytesRead);

typedef McDownloadProgress McGetProgress;
typedef McDownloadProgress McPostProgress;


typedef NSURLSessionTask McURLSessionTask;
typedef void(^McResponseSuccess)(id response);
typedef void(^McResponseFail)(NSError *error);

/*+++++++++++++++++++++++++++++++++++++++
 *  @author lmc, 16-5-18
 *
 *  基于AFNetworking 3.0的网络层封装类.
 *

 */
@interface McNetworking : NSObject

+ (void)setBaseUrl:(NSString *)baseUrl;
+ (NSString *)baseUrl;

/*
 *  配置公共的请求头，只调用一次
 */
+ (void)configHttpHeaders:(NSDictionary *)httpHeaders;
/*!
 *  GET请求接口，若不指定baseurl，可传完整的url
 */
+ (McURLSessionTask *)getWithUrl:(NSString *)url
                          success:(McResponseSuccess)success
                             fail:(McResponseFail)fail;

+ (McURLSessionTask *)getWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                          success:(McResponseSuccess)success
                             fail:(McResponseFail)fail;

+ (McURLSessionTask *)getWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                         progress:(McGetProgress)progress
                          success:(McResponseSuccess)success
                             fail:(McResponseFail)fail;

/*!
 *  POST请求接口，若不指定baseurl，可传完整的url
 */
+ (McURLSessionTask *)postWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                           success:(McResponseSuccess)success
                              fail:(McResponseFail)fail;

+ (McURLSessionTask *)postWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                          progress:(McPostProgress)progress
                           success:(McResponseSuccess)success
                              fail:(McResponseFail)fail;


/*
 *	取消所有请求
 */
+ (void)cancelAllRequest;
/*
 *	取消某个请求。如果是要取消某个请求，最好是引用接口所返回来的HYBURLSessionTask对象，
 *  然后调用对象的cancel方法。如果不想引用对象，这里额外提供了一种方法来实现取消某个请求
 *	@param url				URL，可以是绝对URL，也可以是path（也就是不包括baseurl）
 */
+ (void)cancelRequestWithURL:(NSString *)url;
@end
