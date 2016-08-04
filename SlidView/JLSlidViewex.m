


#import "JLSlidViewex.h"
#import "Masonry.h"


@interface JLSlidViewex()

@property (nonatomic) CGFloat stepLength;

@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;

@property (nonatomic,strong) UIImageView *leftImg;
@property (nonatomic,strong) UIImageView *rightImg;

@property (nonatomic) CGFloat leftViewValue;
@property (nonatomic) CGFloat rightViewValue;

@property (nonatomic,strong) UIImageView *selectedArea;
@property (nonatomic,strong) UIView *backgroundLine;
@property (nonatomic) CGFloat max;
@property (nonatomic) CGFloat min;

@property (nonatomic) CGFloat lineHeight;
@property (nonatomic) CGFloat pointViewW;
@property (nonatomic) CGFloat pointViewH;

@property (nonatomic) CGFloat slidWidth;

@property (nonatomic) CGFloat shouldShowLeftValue;
@property (nonatomic) CGFloat shouldShowRightValue;

@property (nonatomic) CGFloat showRightValue;
@property (nonatomic) CGFloat showLeftValue;

//@property (nonatomic) CGFloat maxLimit;

@end
@implementation JLSlidViewex

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.leftViewValue = 0;
        self.rightViewValue = 0;
        
        self.stepLength = 1;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.equalTo(@(_pointViewW+10));
        make.height.equalTo(@(_pointViewH));
        make.right.equalTo(self.backgroundLine.mas_left).offset(_leftViewValue + _pointViewW);
    }];
    
    [self.rightView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.equalTo(@(_pointViewW+10));
        make.height.equalTo(@(_pointViewH));
        make.left.equalTo(self.backgroundLine).offset(_rightViewValue + _pointViewW);
    }];
}
#pragma mark -Method
- (void)resetRange:(NSArray *)rangeArr
{
    
    if (rangeArr == nil) {
        rangeArr = @[@(_min),@(_max)];
    }
    
    if (rangeArr.count == 2) {
        _showLeftValue = [rangeArr[0] integerValue];
        _showRightValue = [rangeArr[1] integerValue];
        
        _shouldShowLeftValue = _showLeftValue;
        _shouldShowRightValue = _showRightValue;
        
        _leftViewValue = (_shouldShowLeftValue - _min) / (_max - _min) * _slidWidth;
        _rightViewValue = (_shouldShowRightValue - _min) / (_max - _min) * _slidWidth;
        
        [self setupContentIsLeft:YES];
        
        [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backgroundLine.mas_left).offset(_leftViewValue + _pointViewW);
        }];
        [self.rightView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backgroundLine).offset(_rightViewValue + _pointViewW);
        }];
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

- (void)setLineHeight:(CGFloat)lineHeight pointViewW:(CGFloat)pointViewW pointViewH:(CGFloat)pointViewH
{
    [self layoutIfNeeded];
    _lineHeight = lineHeight;
    _pointViewW = pointViewW;
    _pointViewH = pointViewH;
    
    self.leftViewValue = 0;
    self.slidWidth = self.bounds.size.width - _pointViewW * 2 - 20;
    self.rightViewValue = self.slidWidth;
    
    [self setupView];
}

#pragma mark -SetupView
- (void)setupView
{
    self.backgroundLine = [[UIView alloc] initWithFrame:CGRectZero];
    self.backgroundLine.backgroundColor = [UIColor colorWithRed:239/255.0 green:234/255.0 blue:235/255.0 alpha:1];
    [self addSubview:self.backgroundLine];
    
    self.selectedArea = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.selectedArea.image = [UIImage imageNamed:@"slid-selectedview-red"];
    [self addSubview:self.selectedArea];

    self.leftView = [[UIView alloc] initWithFrame:CGRectZero];
    self.leftView.backgroundColor = [UIColor clearColor];
    self.leftView.userInteractionEnabled = YES;
    [self addSubview:self.leftView];
    
    self.rightView = [[UIView alloc] initWithFrame:CGRectZero];
    self.rightView.backgroundColor = [UIColor clearColor];
    self.rightView.userInteractionEnabled = YES;
    [self addSubview:self.rightView];
    
    self.leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slid-btn"]];
    [self.leftView addSubview:self.leftImg];
    
    self.rightImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slid-btn"]];
    [self.rightView addSubview:self.rightImg];
    
    
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self.rightView);
        make.right.equalTo(self.rightView).offset(-10.0f);
    }];
    
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.leftView);
        make.left.equalTo(self.leftView).offset(10.0f);
    }];
    
    [self.backgroundLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10.0f);
        make.right.equalTo(self).offset(-10.0f);
        make.height.equalTo(@(_lineHeight * 0.7));
        make.centerY.equalTo(self);
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.equalTo(@(_pointViewW));
        make.height.equalTo(@(_pointViewH));
        make.right.equalTo(self.backgroundLine.mas_left).offset(_leftViewValue + _pointViewW);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.equalTo(@(_pointViewW+10));
        make.height.equalTo(@(_pointViewH));
        make.left.equalTo(self.backgroundLine).offset(_rightViewValue + _pointViewW);
    }];
    
    [self.selectedArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.equalTo(@(_lineHeight));
        make.left.equalTo(_leftView.mas_centerX);
        make.right.equalTo(_rightView.mas_centerX);
    }];
    
    [self.selectedArea layoutIfNeeded];
}


#pragma mark -Touch
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint loc = [touch locationInView:touch.view.superview];
    
    CGPoint oldLoc = [touch previousLocationInView:touch.view.superview];
    
    CGFloat offsetForH = loc.x - oldLoc.x;
    if (touch.view == _leftView) {
        _leftViewValue += offsetForH;
        
        if (_leftViewValue < 0) {
            _leftViewValue = 0;
        }
        if (_leftViewValue > _rightViewValue) {
            _leftViewValue = _rightViewValue;
        }
    }
    if (touch.view == _rightView) {
        _rightViewValue += offsetForH;
        
        if (_rightViewValue > self.slidWidth ) {
            _rightViewValue = self.slidWidth ;
        }
        if (_rightViewValue < _leftViewValue) {
            _rightViewValue = _leftViewValue;
        }
    }
    self.showLeftValue = _min + ( _max - _min ) * ( _leftViewValue / _slidWidth) ;
    self.showRightValue = _min + ( _max - _min ) * ( _rightViewValue / _slidWidth);
    if (self.showRightValue < self.showLeftValue) {
        self.showRightValue = self.showLeftValue;
    }

    [self setupContentIsLeft:touch.view == _leftView ? YES : NO];
    
    [self layoutSubviews];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.leftViewValue = (_shouldShowLeftValue - _min) / (_max - _min) * _slidWidth;
    self.rightViewValue = (_shouldShowRightValue - _min) / (_max - _min) * _slidWidth;
    [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backgroundLine.mas_left).offset(_leftViewValue + _pointViewW);
    }];
    [self.rightView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundLine).offset(_rightViewValue + _pointViewW);
    }];

    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark -Set
- (void)setMax:(CGFloat)max Min:(CGFloat)min stepLength:(CGFloat)stepLength
{
    if (max > min) {
        _max = max;
        _min = min;
    } else {
        _max = min;
        _min = max;
    }

    if ([@(stepLength) integerValue] > 0) {
        _stepLength = [@(stepLength) integerValue];
    }
    _showLeftValue = _min;
    _showRightValue = _max;
    [self setupContentIsLeft:YES];
}

- (void)setupContentIsLeft:(BOOL)isLeft
{
    _shouldShowLeftValue = ((NSInteger)((self.showLeftValue + self.stepLength / 2) / self.stepLength)) * self.stepLength + _min;
    _shouldShowRightValue = ((NSInteger)((self.showRightValue + self.stepLength / 2) / self.stepLength)) * self.stepLength;

    if (isLeft) {
        if (_shouldShowLeftValue > _shouldShowRightValue) {
            _shouldShowLeftValue = _shouldShowRightValue;
        }
        if (_shouldShowRightValue < _shouldShowLeftValue) {
            _shouldShowRightValue = _shouldShowLeftValue;
        }
    } else {
        if (_shouldShowRightValue < _shouldShowLeftValue) {
            _shouldShowRightValue = _shouldShowLeftValue;
        }
        if (_shouldShowLeftValue > _shouldShowRightValue) {
            _shouldShowLeftValue = _shouldShowRightValue;
        }
    }
    
    self.ChangeLabelValueBlock(_shouldShowLeftValue,_shouldShowRightValue);
}


#pragma mark -Get
- (NSArray *)getConfirmRangeArr
{
    return @[@((NSInteger)_shouldShowLeftValue),@((NSInteger)_shouldShowRightValue)];
}



@end
