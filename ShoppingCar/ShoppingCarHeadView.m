//
//  ShoppingCarHeadView.m
//  ShoppingCar
//
//  Created by DY on 16/9/20.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "ShoppingCarHeadView.h"
#import "ShoppingHeaderModel.h"

@interface ShoppingCarHeadView()

/**背景图片*/
@property (nonatomic,strong) UIImageView *backGroundImageView;
/**家园图片*/
@property (nonatomic,strong) UIImageView *homeImageView;
/**家园名称*/
@property (nonatomic,strong) UILabel *homeNameLb;

@end

@implementation ShoppingCarHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame WithSection:(NSInteger)section HeadModel:(ShoppingHeaderModel *)model{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //底图
        _backGroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cart_title_bg"]];
        _backGroundImageView.frame = self.frame;
        [self addSubview:_backGroundImageView];
        //全选按钮
        _selectAllBtn = [[UIButton alloc]init];
        [_selectAllBtn setImage:[UIImage imageNamed:@"cart_selected_default"] forState:UIControlStateNormal];
        [_selectAllBtn setImage:[UIImage imageNamed:@"cart_selected"] forState:UIControlStateSelected];
        [_selectAllBtn addTarget:self action:@selector(allClick:) forControlEvents:UIControlEventTouchUpInside];
        _selectAllBtn.selected = model.isSelect;
        _selectAllBtn.tag = section + 1000;
        [self addSubview:_selectAllBtn];
        
        //家园名称
        _homeNameLb = [[UILabel alloc] init];
        _homeNameLb.textColor = [UIColor blackColor];
        _homeNameLb.font = [UIFont systemFontOfSize:14];
        _homeNameLb.text = model.homeID;
        [self addSubview:_homeNameLb];
        //小房子图片
        _homeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_title"]];
        [self addSubview:_homeImageView];
        
        _selectAllBtn.frame = CGRectMake(10, 5, 20, 20);
        _homeImageView.frame = CGRectMake(40, 0, 30, 30);
        _homeNameLb.frame = CGRectMake(70, 5, 150, 20);
        
    }
    return self;
}

- (void)allClick:(UIButton *)bt
{
    if([self.delegate respondsToSelector:@selector(shoppingCarHeaderViewDelegat:WithHeadView:)])
    {
        [self.delegate shoppingCarHeaderViewDelegat:bt WithHeadView:self];
    }
}


@end
