//
//  ShoppingHeaderModel.h
//  ShoppingCar
//
//  Created by DY on 16/9/20.
//  Copyright © 2016年 DY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingHeaderModel : NSObject

@property (nonatomic,assign)BOOL isSelect;
@property(nonatomic,copy)NSString * homeID;
@property(nonatomic,strong)NSMutableArray * goodsInfo;

@end
