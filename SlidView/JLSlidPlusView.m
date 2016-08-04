

#import "JLSlidPlusView.h"
#import "JLSlidViewex.h"
#import "Masonry.h"
#define lightColorRandom [UIColor colorWithRed:(arc4random_uniform(30)+220)/255.0 green:(arc4random_uniform(50)+200)/255.0 blue:(arc4random_uniform(70)+180)/255.0 alpha:1.0]

@interface JLSlidPlusView()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) JLSlidViewex *slidView;

@end

@implementation JLSlidPlusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = lightColorRandom;
    }
    return self;
}

#pragma mark -SetupView
- (void)setupViews
{
    [self layoutIfNeeded];
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.leftLabel.textColor = [UIColor blackColor];
    self.leftLabel.text = @"";
    [self addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.rightLabel.textColor = [UIColor blackColor];
    self.rightLabel.text = @"";
    [self addSubview:self.rightLabel];
    
    self.slidView = [[JLSlidViewex alloc] initWithFrame:CGRectZero];
    [self addSubview:self.slidView];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.0f);
        make.top.equalTo(self).offset(10.0f);
        make.height.equalTo(@30);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16.0f);
        make.top.equalTo(self).offset(10.0f);
        make.height.equalTo(@30);
    }];

    [self.slidView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftLabel.mas_bottom).offset(0);
        make.left.equalTo(self).offset(4.0f);
        make.right.equalTo(self).offset(-4.0f);
        make.bottom.equalTo(self).offset(0);
    }];
    
    [_slidView setLineHeight:15 pointViewW:25 pointViewH:42];
    __weak __typeof(self) weakSelf = self;
    _slidView.ChangeLabelValueBlock = ^(NSInteger leftValue, NSInteger rightValue){
        
        weakSelf.leftLabel.text = [NSString stringWithFormat:@"%lu",leftValue];
        weakSelf.rightLabel.text = [NSString stringWithFormat:@"%lu",rightValue];
    };
}

#pragma mark -Set

- (void)setMax:(NSInteger)max Min:(NSInteger)min stepLength:(NSInteger)stepLength
{
    [self setupViews];
    [_slidView setMax:max Min:min stepLength:stepLength];
}

- (void)setMoveEndCompletionBlock:(void (^)(NSString *))MoveEndCompletionBlock
{
    _MoveEndCompletionBlock = MoveEndCompletionBlock;
}

#pragma mark -Get

- (NSArray *)getConfirmRangeArr
{
    return [self.slidView getConfirmRangeArr];
}

#pragma mark -Method
- (void)resetRange:(NSArray *)rangeArr
{
    [self.slidView resetRange:rangeArr];
}

@end
