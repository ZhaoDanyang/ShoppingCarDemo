//
//  ShoppingModel.h
//  ShoppingCar
//
//  Created by DY on 16/9/20.
//  Copyright © 2016年 DY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingModel : NSObject

//商品属性
@property(nonatomic,copy)NSString * goodsID;
@property(nonatomic,copy)NSString * goodsTitle;
@property(nonatomic,copy)NSString * goodsCount;
@property(nonatomic,copy)NSString * goodsColor;
@property(nonatomic,copy)NSString * goodsSize;
@property(nonatomic,copy)NSString * goodsPrice;
@property(nonatomic,copy)NSString * goodsImageURL;
//测试image
@property(nonatomic,copy)NSString * goodsImage;
//选中状态
@property(nonatomic,assign)BOOL isSelect;

@end
