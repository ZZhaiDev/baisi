//
//  ZJTopicCell.m
//  百思
//
//  Created by Zijia Zhai on 3/31/16.
//  Copyright © 2016 zijia. All rights reserved.
//

#import "ZJTopicCell.h"
#import <UIImageView+WebCache.h>
#import "fiveTableModel.h"

@interface ZJTopicCell()


/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;


@end

@implementation ZJTopicCell

//- (void)awakeFromNib
//{
//    UIImageView *bgView = [[UIImageView alloc] init];
//    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
//    self.backgroundView = bgView;
//}


- (void)setDatas:(fiveTableModel *)datas
{
    
    _datas = datas;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:datas.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
    self.nameLabel.text = datas.name;
    self.createTimeLabel.text = datas.create_time;

    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:datas.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:datas.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:datas.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:datas.comment placeholder:@"评论"];
    
}
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    //    NSString *title = nil;
    //    if (count == 0) {
    //        title = placeholder;
    //    } else if (count > 10000) {
    //        title = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    //    } else {
    //        title = [NSString stringWithFormat:@"%zd", count];
    //    }
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
        [button setTitle:placeholder forState:UIControlStateNormal];
    
}


//重写setframe 设置cell的frame 使得cell在tableView里是一个个小的表格。。

- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    NSLog(@"sdfg");
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];

}

@end
