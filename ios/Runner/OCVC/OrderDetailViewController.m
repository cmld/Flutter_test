//
//  OrderDetailViewController.m
//  Runner
//
//  Created by yl on 2023/10/24.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *myTableV;

@property(nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray arrayWithArray:@[@1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1, @1]];
    [self setMytableView];
    
    // Do any additional setup after loading the view.
}

- (void)setMytableView{
    _myTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _myTableV.delegate = self;
    _myTableV.dataSource = self;
    _myTableV.showsVerticalScrollIndicator = NO;
    _myTableV.showsHorizontalScrollIndicator = NO;
    _myTableV.tableFooterView = [UIView new];
    _myTableV.backgroundColor = [UIColor whiteColor];// TODO:-Armand
//    _myTableV.contentInset = [self defaultInsets];// TODO:-Armand
//    _myTableV.separatorStyle = UITableViewCellSeparatorStyleNone; //隐藏自带分隔线
    [_myTableV registerNib:[UINib nibWithNibName:@"JTPaymentHisTabCell" bundle:nil] forCellReuseIdentifier:@"JTPaymentHisTabCell"];
    if (@available(iOS 11.0, *)) {
        _myTableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _myTableV.estimatedSectionHeaderHeight = 0;
    }
    if (@available(iOS 15.0, *)) {
        _myTableV.sectionHeaderTopPadding = 0;
    }
//    //刷新
//    UnboxingRefreshHeader * refreshHeader = [UnboxingRefreshHeader headerWithRefreshingBlock:^{
////        [self endRefresh];
//        [self request];
//    }];
//    refreshHeader.ignoredScrollViewContentInsetTop = 8;
//    _myTableV.mj_header = refreshHeader;
    [self.view addSubview:_myTableV];
}

// MARK: TableView Delegate
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_dataSource[indexPath.row]  isEqual: @1] ? 50: 100;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.contentView.backgroundColor = UIColor.grayColor;
    cell.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *title = [[UILabel alloc] initWithFrame: CGRectMake(15,5, 100, 15)];
    title.text = @"tilte";
    [cell addSubview:title];
    
    UILabel *title1 = [[UILabel alloc] initWithFrame: CGRectMake(15,65, 100, 15)];
    title1.text = @"desc";
    [cell addSubview:title1];
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_dataSource[indexPath.row] isEqual:@1]){
        _dataSource[indexPath.row] = @2;
    } else {
        _dataSource[indexPath.row] = @1;
    }
    [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation: UITableViewRowAnimationNone];
}




@end
