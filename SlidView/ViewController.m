

#import "ViewController.h"
#import "JLSlidPlusView.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    JLSlidPlusView *slidView = [[JLSlidPlusView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:slidView];
    [slidView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@300);
        make.centerX.centerY.equalTo(self.view);
    }];
    [slidView setMax:1000 Min:10 stepLength:200];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
