//
//  ViewController.m
//  treeView
//
//  Created by Mike on 16/7/20.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "ViewController.h"
#import "AreaCell.h"
#import "AreaModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, AreaCellDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ViewController

static NSString *reuseIdentifier = @"reuseIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createUI];
    [self setUI];
    [self requestNetDataThenRefresh];
}

- (void)createUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectOffset(self.view.bounds, 0, 20.f)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"AreaCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)requestNetDataThenRefresh {
    AreaModel *modelChinaJiangSuNanJing = [[AreaModel alloc] init];
    modelChinaJiangSuNanJing.name = @"南京";
    modelChinaJiangSuNanJing.level = 2;
    modelChinaJiangSuNanJing.childModelArray = nil;
    
    AreaModel *modelChinaJiangSuSuZhou = [[AreaModel alloc] init];
    modelChinaJiangSuSuZhou.name = @"苏州";
    modelChinaJiangSuSuZhou.level = 2;
    modelChinaJiangSuSuZhou.childModelArray = nil;
    
    
    AreaModel *modelChinaJiangSu = [[AreaModel alloc] init];
    modelChinaJiangSu.name = @"江苏";
    modelChinaJiangSu.level = 1;
    modelChinaJiangSu.childModelArray = @[modelChinaJiangSuNanJing, modelChinaJiangSuSuZhou];
    
    AreaModel *modelChinaBeijingDongCheng = [[AreaModel alloc] init];
    modelChinaBeijingDongCheng.name = @"东城区";
    modelChinaBeijingDongCheng.level = 2;
    modelChinaBeijingDongCheng.childModelArray = nil;
    
    AreaModel *modelChinaBeijingXiCheng = [[AreaModel alloc] init];
    modelChinaBeijingXiCheng.name = @"西城区";
    modelChinaBeijingXiCheng.level = 2;
    modelChinaBeijingXiCheng.childModelArray = nil;
    
    AreaModel *modelChinaBeijing = [[AreaModel alloc] init];
    modelChinaBeijing.name = @"北京";
    modelChinaBeijing.level = 1;
    modelChinaBeijing.childModelArray = @[modelChinaBeijingDongCheng, modelChinaBeijingXiCheng];
    
    
    AreaModel *modelChina = [[AreaModel alloc] init];
    modelChina.name = @"中国";
    modelChina.level = 0;
    modelChina.childModelArray = @[modelChinaJiangSu, modelChinaBeijing];
    
    AreaModel *modelUSCalifornia = [[AreaModel alloc] init];
    modelUSCalifornia.name = @"加利福尼亚";
    modelUSCalifornia.level = 1;
    modelUSCalifornia.childModelArray = nil;
    
    AreaModel *modelUSWashonton = [[AreaModel alloc] init];
    modelUSWashonton.name = @"华盛顿";
    modelUSWashonton.level = 1;
    modelUSWashonton.childModelArray = nil;
    
    AreaModel *modelUS = [[AreaModel alloc] init];
    modelUS.name = @"美国";
    modelUS.level = 0;
    modelUS.childModelArray = @[modelUSCalifornia, modelUSWashonton];
    
    _dataArray = @[modelChina, modelUS];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - AreaCellDelegate

- (void)areaCell:(AreaCell *)areaCell didClickedOnCheckBoxImageView:(UIImageView *)checkBoxImageView {
    areaCell.model.isChecked = !areaCell.model.isChecked;
    [areaCell.model setCheckFatherInModelArray:_dataArray];
    [areaCell.model setCheckChild];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = [MKTreeViewModel rowCountForModelArray:_dataArray];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AreaCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.model = (AreaModel *)[MKTreeViewModel modelAtRow:indexPath.row inArray:_dataArray];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AreaCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.model.expanded = !cell.model.expanded;
    [self.tableView reloadData];
    return;
}

@end
