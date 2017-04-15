//
//  main.m
//  App1504_Blocks
//
//  Created by iOS-School-1 on 15.04.17.
//  Copyright © 2017 Learning. All rights reserved.
//

#import <Foundation/Foundation.h>

//2   void f(int a, int (^inc)(void)){
//    NSLog(@"%@", @(a+inc()));
//}

@interface BlockTestClass: NSObject

-(void) testMemory;

@end

@interface BlockTestClass(){
    NSString *_str2;
}

@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) void (^test)(void);

@end

@implementation BlockTestClass

-(instancetype) init{
    
    self = [super init];
    if(self){
        _str = @"Hello World";
        _str2 = @"Hello World";
    }
    return self;
}

-(void) testMemory{
    __weak typeof (self) weakSelf = self;   //в библе libExtObjc?  можно писать просто @strongify(self);
    self.test = ^void(void){
        __strong typeof (self) strongSelf = weakSelf;
        NSLog(@"%@", strongSelf->_str2); // селф держит
    };
    self.test();
}

@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //        BOOL flag = YES;
        //        void(^block)(NSString *) = ^void(NSString* s)
        //        {
        //            if ( flag )
        //                NSLog(@"String: %@", s);
        //        };
        //        block(@"Hello, World");
        
        //2        NSLog(@"Hello, World!");
        //
        //        __block int a = 10;
        //        int (^inc)(void)=^int(void){
        //            NSLog(@"%@",@(a));
        //            return a;
        //        };
        //        a+=10;
        //        f(2, inc);
        
//3        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@" Hello wORLD!");
//            });
//        });
        __block int a = 0;
        int(^inc)(void) = ^int (void){
            return ++a;
        };
        
        [inc copy]; // будет перенесен в кучу
        
        BlockTestClass *test = [BlockTestClass new];
        [test testMemory];
        
        
    }
    return 0;
}
