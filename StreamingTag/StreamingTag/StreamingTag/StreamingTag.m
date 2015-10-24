//
//  StreamingTag.m
//  StreamingTag
//
//  Created by MyMac on 15/10/24.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "StreamingTag.h"

#define Horizontal_Padding 7.0f
#define Vertical_Padding 3.0f
#define margin 10.0f

@interface StreamingTag ()

@property (nonatomic,assign) CGRect previousFrame;

@property (nonatomic,assign) int totalHeight;

@property (nonatomic,strong) NSMutableArray *tagArr;

@end

@implementation StreamingTag

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.totalHeight = 0;
        self.tagArr = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setTagWithTagArr:(NSArray *)arr{
    self.previousFrame = CGRectZero;
    [self.tagArr addObjectsFromArray:arr];
    [arr enumerateObjectsUsingBlock:^(NSString*str, NSUInteger idx, BOOL *stop) {
        
        
        
        UIButton*tagBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        tagBtn.frame=CGRectZero;
        
        if(self.singleTagColor){
            //可以单一设置tag的颜色
            tagBtn.backgroundColor=self.singleTagColor;
        }else{
            //tag颜色多样
            tagBtn.backgroundColor=[UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];
        }
        if(_canTouch){
            tagBtn.userInteractionEnabled=YES;
            
        }else{
            
            tagBtn.userInteractionEnabled=NO;
        }
        [tagBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [tagBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        tagBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [tagBtn setTitle:str forState:UIControlStateNormal];
        tagBtn.tag= idx;
        tagBtn.layer.cornerRadius=13;
        tagBtn.layer.borderColor=[UIColor redColor].CGColor;
        tagBtn.layer.borderWidth=0.4;
        tagBtn.clipsToBounds=YES;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
        CGSize Size_str=[str sizeWithAttributes:attrs];
        Size_str.width += Horizontal_Padding * 3;
        Size_str.height += Vertical_Padding * 3;
        
        CGRect newRect = CGRectZero;
        
        if (self.previousFrame.origin.x + self.previousFrame.size.width + Size_str.width + margin > self.bounds.size.width) {
            
            newRect.origin = CGPointMake(10, self.previousFrame.origin.y + Size_str.height + margin);
            self.totalHeight +=Size_str.height + margin;
        }
        else {
            newRect.origin = CGPointMake(self.previousFrame.origin.x + self.previousFrame.size.width + margin, self.previousFrame.origin.y);
            
        }
        newRect.size = Size_str;
        [tagBtn setFrame:newRect];
        self.previousFrame=tagBtn.frame;
        [self setHeight:self andHeight:self.totalHeight+Size_str.height + margin];
        [self addSubview:tagBtn];
        
        
    }
     
     ];
    if(self.StreamTagViewBg){
        
        self.backgroundColor=self.StreamTagViewBg;
        
    }else{
        
        self.backgroundColor=[UIColor whiteColor];
        
    }
}


#pragma mark - 改变控件高度
- (void)setHeight:(UIView *)view andHeight:(CGFloat)height{
    CGRect tempFrame = view.frame;
    tempFrame.size.height = height;
    view.frame = tempFrame;
}

- (void)tagBtnClick:(UIButton *)button{
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        button.backgroundColor = [UIColor orangeColor];
    }else{
        button.backgroundColor = [UIColor whiteColor];
    }
    
    [self didSelectItems];
    
}

- (void)didSelectItems{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *tempBtn = (UIButton *)view;
            if (tempBtn.selected) {
                [arr addObject:self.tagArr[tempBtn.tag]];
            }
        }
    }
    self.didselectedItemBlock(arr);
}

@end
