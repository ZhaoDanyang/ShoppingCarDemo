//
//  ShoppingCell.h
//  ShoppingCar
//
//  Created by DY on 16/9/19.
//  Copyright © 2016年 DY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingModel;
@class ShoppingCell;

@protocol ShoppingCellDelegate <NSObject>

/**
 *  cell关于选中的代理方法
 *
 *  @param cell     cell
 *  @param selectBt cell左边选中按钮
 */
- (void)shoppingCellDelegate:(ShoppingCell *)cell WithSelectButton:(UIButton *)selectBt;
/**
 *  cell关于数量编辑的代理方法
 *
 *  @param cell    cell
 *  @param countBt cell加减数量按钮
 */
- (void)shoppingCellDelegateForGoodsCount:(ShoppingCell *)cell WithCountButton:(UIButton *)countBt;

@end


@interface ShoppingCell : UITableViewCell

@property (nonatomic,strong) ShoppingModel *model;

/**商品已选数量*/
@property(nonatomic,assign)NSInteger chooseCount;

/**cell代理对象*/
@property(nonatomic,assign)id<ShoppingCellDelegate> delegate;

/**添加按钮*/
@property (nonatomic,strong) UIButton *addBtn;
/**减少按钮*/
@property (nonatomic,strong) UIButton *reduceBtn;

+ (instancetype) cellWithTableView :(UITableView *)tableView;



@end
