//
//  ViewController.m
//  ShoppingCar
//
//  Created by DY on 16/9/19.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "ViewController.h"
#import "ShoppingCell.h"
#import "ShoppingCarHeadView.h"
#import "ShoppingModel.h"
#import "ShoppingHeaderModel.h"
#import "ShoppingCarBottomView.h"
#import "ShoppingCarBottomModel.h"
#import <MJExtension.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ShoppingCellDelegate,ShoppingCarHeaderViewDelegate,ShoppingCarBottomViewDelegate>

@property (nonatomic,strong) NSMutableArray *carLists;

/**
 *  数据模型数组
 */
@property(nonatomic,strong) NSMutableArray * modelArrs;
/**
 *  组数据模型
 */
@property(nonatomic,strong) NSMutableArray * groupArrs;

@property(nonatomic,strong) UITableView *tableView;

/**
 *  全选所有商品按钮
 */
@property(nonatomic,weak)UIButton * allselectBt;

@property(nonatomic,strong) ShoppingCarBottomModel * bottomModel;
@property(nonatomic,strong) ShoppingModel *cartModel;
/**
 *  全选按钮
 */
@property(nonatomic,assign)BOOL isallSel;
/**
 *  是否结算
 */
@property(nonatomic,assign)BOOL isSettle;

@property(nonatomic,assign) double allPrice;

@end

//static NSString *ID = @"cell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"购物车";
    
    self.bottomModel = [[ShoppingCarBottomModel alloc]init];
    
    [self setupTableview];
}

- (NSMutableArray *)carLists{
    
    if (_carLists == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shopping_json.json" ofType:nil];
        
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        _carLists = dict[@"shoppingCar"];
        
        NSMutableArray * modelArrs = [NSMutableArray array];
        for (NSDictionary * dict in _carLists)
        {
        NSMutableArray * modelArr = [ShoppingModel mj_objectArrayWithKeyValuesArray:dict[@"goodsInfo"]];
            
            [modelArrs addObject:modelArr];
        }
        self.modelArrs = modelArrs;
        
        NSMutableArray * groupArrs = [ShoppingHeaderModel mj_objectArrayWithKeyValuesArray:_carLists];
        self.groupArrs = groupArrs;
        [self.tableView reloadData];

    }
    return _carLists;
}

- (void)setupTableview {
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    self.tableView = tableview;

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return self.carLists.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary * dict = self.carLists[section];
    NSArray * datas = [ShoppingModel mj_objectArrayWithKeyValuesArray:dict[@"goodsInfo"]];
    
    return datas.count;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShoppingCell *cell = [ShoppingCell cellWithTableView:tableView];
    
    cell.model = self.modelArrs[indexPath.section][indexPath.row];
    
    cell.delegate = self;
    
    return cell;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    [self setupBottomView];
    
    CGRect frame = CGRectMake(0, 0,self.view.frame.size.width, 30);
    ShoppingHeaderModel * headModel = self.groupArrs[section];
    ShoppingCarHeadView * headView = [[ShoppingCarHeadView alloc]initWithFrame:frame WithSection:section HeadModel:headModel];
    
    headView.delegate = self;
    
    return headView;
}

- (void) setupBottomView{
    
    UIButton * bt = [[UIButton alloc]init];
    self.allselectBt = bt;
    ShoppingCarBottomView * bottomView = [[ShoppingCarBottomView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height- 50, self.view.frame.size.width, 50) With:self.bottomModel];
    bottomView.delegate = self;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [self imputedAllPrice];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

/**
 *  cell的代理方法
 *
 *  @param cell     cell可以拿到indexpath
 *  @param selectBt 选中按钮
 */
- (void)shoppingCellDelegate:(ShoppingCell *)cell WithSelectButton:(UIButton *)selectBt
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    ShoppingModel * model = self.modelArrs[indexPath.section][indexPath.row];
    NSArray * arr = self.modelArrs[indexPath.section];
    model.isSelect = !selectBt.selected;
    int counts = 0;
    for (ShoppingModel * modelArr in arr)
    {
        if(modelArr.isSelect)
        {
            counts ++ ;
        }
    }
    ShoppingHeaderModel * headerModel = self.groupArrs[indexPath.section];
    if(counts == arr.count)
    {
        headerModel.isSelect = YES;
    }else
    {
        headerModel.isSelect = NO;
        self.allselectBt.selected = NO;
    }
    [self isallSelectAllPrice];
    [self.tableView reloadData];
}


/**
 *  cell的代理方法
 *
 *  @param cell    cell可以拿到indexpath
 *  @param countBt 加减按钮
 */
- (void)shoppingCellDelegateForGoodsCount:(ShoppingCell *)cell WithCountButton:(UIButton *)countBt
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ShoppingModel *model = self.modelArrs[indexPath.section][indexPath.row];
    //判断是加号还是减号按钮   addbt的tag值是1
    if(countBt.tag == 1)
    {
        if(model.goodsCount.intValue >= 99)
        {
            countBt.enabled = NO;
        }else
        {
            countBt.enabled = YES;
            cell.reduceBtn.enabled = YES;
            model.goodsCount = [NSString stringWithFormat:@"%d",model.goodsCount.intValue + 1];
        }
    }else
    {
        if(model.goodsCount.intValue == 1)
        {
            countBt.enabled = NO;
        }else
        {
            cell.addBtn.enabled = YES;
            countBt.enabled = YES;
            model.goodsCount = [NSString stringWithFormat:@"%d",model.goodsCount.intValue - 1];
        }
    }
    [self.tableView reloadData];
}

- (void)shoppingCarHeaderViewDelegat:(UIButton *)bt WithHeadView:(ShoppingCarHeadView *)view
{
    
    bt.selected = !bt.selected;
    NSInteger indexpath = bt.tag - 1000;
    ShoppingHeaderModel *headModel = self.groupArrs[indexpath];
    NSArray *allSelectArr = self.modelArrs[indexpath];
    if(bt.selected)
    {
        for (ShoppingModel * model in allSelectArr)
        {
            model.isSelect = YES;
            headModel.isSelect = YES;
        }
    }else
    {
        for (ShoppingModel * model in allSelectArr)
        {
            model.isSelect = NO;
            headModel.isSelect = NO;
        }
    }
    [self isallSelectAllPrice];
    [self.tableView reloadData];
}

/**
 *  footer 全选和取消
 */
- (void)shoppingcarBottomViewDelegate:(UIButton *)allselBt
{
    allselBt.selected = ! allselBt.selected;
    self.bottomModel.isSelect = allselBt.selected;
    if(allselBt.selected)
    {
        self.isallSel = YES;
    }else
    {
        self.isallSel = NO;
    }
    //逻辑
    if (self.isallSel)
    {
        for (NSArray * arr in self.modelArrs)
        {
            for (ShoppingModel * model in arr)
            {
                model.isSelect = YES;
            }
        }
        for (ShoppingHeaderModel *headModel in self.groupArrs)
        {
            headModel.isSelect = YES;
        }
    }else
    {
        for (NSArray * arr in self.modelArrs)
        {
            for (ShoppingModel * model in arr)
            {
                model.isSelect = NO;
            }
        }
        for (ShoppingHeaderModel *headModel in self.groupArrs)
        {
            headModel.isSelect = NO;
        }
    }
    [self.tableView reloadData];
}
/**
 *  遍历所有是否全选
 */
- (void)isallSelectAllPrice
{
    for (NSArray * arr in self.modelArrs)
    {
        for (ShoppingModel * model in arr)
        {
            if (!model.isSelect)
            {
                self.bottomModel.isSelect = NO;
                return;
            }else
            {
                self.bottomModel.isSelect = YES;
            }
        }
    }
}
/**
 *  计算总价
 */
- (void)imputedAllPrice
{
    NSLog(@"开始计算总价");
    int allprice = 0;
    int allCount = 0;
    for (NSArray * goodsArr in self.modelArrs)
    {
        for (ShoppingModel * goodsModel in goodsArr)
        {
            
            if(goodsModel.isSelect == YES)
            {
                int price = goodsModel.goodsCount.intValue * goodsModel.goodsPrice.intValue;
                int count = goodsModel.goodsCount.intValue;
                allCount = count + allCount;
                allprice = price + allprice;
            }
        }
    }
    NSString * priceText = [NSString stringWithFormat:@"总计 : %.2f",allprice / 100.0];
    self.bottomModel.priceText = priceText;
    self.bottomModel.counts = allCount;
    NSLog(@"总价计算完成=%@",self.bottomModel.priceText);
}
@end
