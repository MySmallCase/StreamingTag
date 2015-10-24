//
//  ViewController.m
//  StreamingTag
//
//  Created by MyMac on 15/10/24.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "ViewController.h"
#import "StreamingTag.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic,strong) NSArray *strArr; //标签数组

@property (nonatomic,strong) StreamingTag *tempTag;

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [self.view addSubview:self.scrollView];
    
    //添加全部文本标签
    self.strArr = @[@"大好人",@"自定义流式标签",@"github",@"code4app",@"已婚",@"阳光开朗",@"慷慨大方帅气身材好",@"仗义",@"值得一交的朋友",@"值得一交的朋友",@"值得的交",@"值得一交的朋友",@"值得一交的朋友",@"大好人",@"自定义流式标签",@"github",@"code4app",@"已婚",@"大好人",@"自定义流式标签",@"github",@"code4app",@"已婚",@"阳光开朗",@"慷慨大方帅气身材好",@"仗义",@"值得一交的朋友",@"值得一交的朋友",@"值得的交",@"值得一交的朋友",@"值得一交的朋友",@"大好人",@"自定义流式标签",@"github",@"code4app",@"已婚"];
    
    StreamingTag *tagList = [[StreamingTag alloc] init];
    tagList.frame = CGRectMake(0, 80, ScreenW, 0);
    tagList.canTouch = YES;
    tagList.singleTagColor = [UIColor whiteColor];
    [tagList setTagWithTagArr:self.strArr];
    [self.scrollView addSubview:tagList];
    
    
    //添加选中的文本标签
    [tagList setDidselectedItemBlock:^(NSArray *arr) {
        [self.tempTag removeFromSuperview];
        StreamingTag *selectedItems = [[StreamingTag alloc] initWithFrame:CGRectMake(0,tagList.frame.origin.y + tagList.frame.size.height + 40, ScreenW, 0)];
        selectedItems.singleTagColor = [UIColor whiteColor];
        selectedItems.canTouch = NO;
        [selectedItems setTagWithTagArr:arr];
        [self.scrollView addSubview:selectedItems];
        self.scrollView.contentSize = CGSizeMake(ScreenW, CGRectGetMaxY(selectedItems.frame) + 10);
        self.tempTag = selectedItems;
    }];
    
}

@end
