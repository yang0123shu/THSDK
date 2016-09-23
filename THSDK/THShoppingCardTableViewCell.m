//
//  THShoppingCardTableViewCell.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/31.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THShoppingCardTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation THShoppingCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(NSString*)UTF8_To_GB2312:(NSString*)utf8string
{
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* gb2312data = [utf8string dataUsingEncoding:encoding];
    return [[NSString alloc] initWithData:gb2312data encoding:encoding];
}


-(void)refreshCellWiththumbImageUrl:(NSString*)urlString value:(NSString*)value vailideDate:(NSString*)date
{
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageCacheMemoryOnly];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",[self UTF8_To_GB2312:value]]];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(1, attri.string.length - 1)];
    
    self.valueLabel.attributedText = attri;
    self.dateLabel.text = date;
}


@end
