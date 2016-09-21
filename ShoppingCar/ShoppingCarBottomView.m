//
//  ShoppingCarBottomView.m
//  ShoppingCar
//
//  Created by DY on 16/9/20.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "ShoppingCarBottomView.h"
#import "ShoppingCarBottomModel.h"

@implementation ShoppingCarBottomView

- (instancetype)initWithFrame:(CGRect)frame With:(ShoppingCarBottomModel *)bottomModel{
    
    self = [super initWithFrame:frame];
    if(self)
    {
        _allselectBtn = [[UIButton alloc]init];
        [_allselectBtn setImage:[UIImage imageNamed:@"cart_selected_default"] forState:UIControlStateNormal];
        [_allselectBtn setImage:[UIImage imageNamed:@"cart_selected"] forState:UIControlStateSelected];
        _allselectBtn.selected = bottomModel.isSelect;
        [_allselectBtn addTarget:self action:@selector(alllselClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_allselectBtn];
        
        UILabel * allselectLabel = [[UILabel alloc]init];
        allselectLabel.text = @"全选";
        allselectLabel.textColor = [UIColor blackColor];
        allselectLabel.font = [UIFont systemFontOfSize:12];
        allselectLabel.textAlignment = 0;
        [self addSubview:allselectLabel];
        
        _resultPriceLl = [[UILabel alloc]init];
        _resultPriceLl.font = allselectLabel.font;
        _resultPriceLl.textAlignment = 0;
        _resultPriceLl.textColor = [UIColor redColor];
        _resultPriceLl.text = bottomModel.priceText;
        _resultPriceLl.font = [UIFont systemFontOfSize:12];
        [self addSubview:_resultPriceLl];
        
        UIButton *endButton = [[UIButton alloc]init];
        endButton.backgroundColor = [UIColor redColor];
        NSString *endStr = [NSString stringWithFormat:@"结算(共%d件)",bottomModel.counts];
        endButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [endButton setTitle:endStr forState:UIControlStateNormal];
        [self addSubview:endButton];
        
        
        _allselectBtn.frame = CGRectMake(10, 5, 20, 20);
        
        allselectLabel.frame = CGRectMake(10, 30, 60, 20);
        
        _resultPriceLl.frame = CGRectMake(70, 10, 80, 30);
        
        endButton.frame = CGRectMake(250, 0, self.frame.size.width-250, self.frame.size.height);
        
    }
    return self;

}

//全选点击
- (void)alllselClick:(UIButton *)sender
{
    if([self.delegate respondsToSelector:@selector(shoppingcarBottomViewDelegate:)])
    {
        [self.delegate shoppingcarBottomViewDelegate:sender];
    }
}
@end
