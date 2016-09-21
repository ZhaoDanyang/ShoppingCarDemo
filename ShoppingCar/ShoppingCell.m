//
//  ShoppingCell.m
//  ShoppingCar
//
//  Created by DY on 16/9/19.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "ShoppingCell.h"
#import "ShoppingModel.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface ShoppingCell()
/**筛选按钮*/
@property (nonatomic,strong) UIButton *selectBtn;
/**商品*/
@property (nonatomic,strong) UILabel *goodsLb;
/**尺寸*/
@property (nonatomic,strong) UILabel *sizeLb;
/**颜色*/
@property (nonatomic,strong) UILabel *colorLb;
/**价格*/
@property (nonatomic,strong) UILabel *priceLb;
/**数量*/
@property (nonatomic,strong) UITextField *numbersTf;
/**商品图片*/
@property (nonatomic,strong) UIImageView *goodsImage;




@end

static NSString *ID = @"cell";

@implementation ShoppingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    ShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[ShoppingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupUI];
    }
    return self;
}

/**
 *  初始化控件
 */
- (void) setupUI{
    
    _selectBtn = [[UIButton alloc]init];
    [_selectBtn setImage:[UIImage imageNamed:@"cart_selected_default"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"cart_selected"] forState:UIControlStateSelected];
    _selectBtn.tag = 0;
    [_selectBtn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectBtn];

    _addBtn = [[UIButton alloc]init];
    [_addBtn setImage:[UIImage imageNamed:@"cart_btn_add"] forState:UIControlStateNormal];
    _addBtn.tag = 1;
    [_addBtn addTarget:self action:@selector(goodsCountNumClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:_addBtn];
    
    _reduceBtn = [[UIButton alloc]init];
    [_reduceBtn setImage:[UIImage imageNamed:@"cart_btn_reduce"] forState:UIControlStateNormal];
    _reduceBtn.tag = 2;
    [_reduceBtn addTarget:self action:@selector(goodsCountNumClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:_reduceBtn];

    _goodsImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_goodsImage];
    
    _goodsLb = [[UILabel alloc]init];
    _goodsLb.font = [UIFont systemFontOfSize:14];
    _goodsLb.numberOfLines = 0;
    [self.contentView addSubview:_goodsLb];
    
    _sizeLb = [[UILabel alloc]init];
    _sizeLb.font = [UIFont systemFontOfSize:14];
    _sizeLb.textColor = [UIColor grayColor];
    [self.contentView addSubview:_sizeLb];

    _colorLb = [[UILabel alloc]init];
    _colorLb.font = [UIFont systemFontOfSize:14];
    _colorLb.textColor = [UIColor grayColor];
    [self.contentView addSubview:_colorLb];

    _priceLb = [[UILabel alloc]init];
    _priceLb.font = [UIFont systemFontOfSize:14];
    _priceLb.textColor = [UIColor redColor];
    [self.contentView addSubview:_priceLb];

    _numbersTf = [[UITextField alloc]init];
    _numbersTf.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_numbersTf];
    
    [self setUIFrame];

}

/**
 *  设置frame
 */
- (void) setUIFrame{
    
    CGFloat btnW = 30;
    
    _selectBtn.frame = CGRectMake(10, 65, 20, 20);
    _goodsImage.frame = CGRectMake(40, 10, 100, 130);
    _goodsLb.frame = CGRectMake(150, _goodsImage.frame.origin.y, 220, 40);
    _sizeLb.frame = CGRectMake(150, 50, 80, 20);
    _colorLb.frame = CGRectMake(240, 50, 80, 20);
    _priceLb.frame = CGRectMake(150, 80, 80, 20);
    _addBtn.frame = CGRectMake(150, 110, btnW, btnW);
    _numbersTf.frame = CGRectMake(180, 110, btnW, btnW);
    _reduceBtn.frame = CGRectMake(210, 110, btnW, btnW);
}


/**
 *  模型赋值
 */
- (void)setModel:(ShoppingModel *)model
{
    self.selectBtn.selected = model.isSelect;
    self.goodsImage.image = [UIImage imageNamed:model.goodsImage];
    self.numbersTf.text = model.goodsCount;//数量
    if(self.numbersTf.text.intValue>1)
    {
        self.reduceBtn.enabled = YES;
    }
    self.goodsLb.text = model.goodsTitle;//商品标题
    if ([model.goodsColor isEqualToString:@"Single"])//商品颜色
    {
        self.colorLb.text = @"";
    }else
    {
        self.colorLb.text = [NSString stringWithFormat:@"颜色:  %@",model.goodsColor];
    }
    if([model.goodsSize isEqualToString:@"Single"])//商品尺寸
    {
        self.sizeLb.text = @"";
    }else
    {
        self.sizeLb.text = [NSString stringWithFormat:@"尺寸: %@",model.goodsSize];
    }
    self.priceLb.text = [NSString stringWithFormat:@"￥%.2f",model.goodsPrice.intValue / 100.0];

}

/**
 *  监听数量文本框  编辑完成时调用
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.numbersTf = textField;
    if (self.numbersTf.text.intValue < 0)
    {
        self.numbersTf.text = @"1";
    }
    if(self.numbersTf.text.intValue > 99)
    {
        self.numbersTf.text = @"99";
        self.addBtn.enabled = NO;
    }
    if(self.numbersTf.text.intValue == 1)
    {
        self.reduceBtn.enabled = NO;
    }
    self.chooseCount = self.numbersTf.text.intValue;
}


/**
 *  选择按钮的点击方法
 */
- (void)selectButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(shoppingCellDelegate:WithSelectButton:)])
    {
        [self.delegate shoppingCellDelegate:self WithSelectButton:sender];
    }
}

/**
 *  编辑数量的点击方法
 */
- (void)goodsCountNumClick:(UIButton *)sender
{
    
    if([self.delegate respondsToSelector:@selector(shoppingCellDelegateForGoodsCount:WithCountButton:)])
    {
        [self.delegate shoppingCellDelegateForGoodsCount:self WithCountButton:sender];
    }
}
@end
