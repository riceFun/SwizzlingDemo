//
//  Person.m
//  SwizzlingDemo
//
//  Created by riceFun on 2018/6/26.
//  Copyright © 2018年 riceFun. All rights reserved.
//

#import "Person.h"

@implementation Person
//instance method
-(void)eatFood{
    NSLog(@"person eat chicken");
}

-(void)takePhoto{
    NSLog(@"person take picture with chicken");
}

//class method
+(void)washCloth{
    NSLog(@"person wash clothes");
}

+(void)climbUpTree{
    NSLog(@"person wash climb up a tree");
}
@end
