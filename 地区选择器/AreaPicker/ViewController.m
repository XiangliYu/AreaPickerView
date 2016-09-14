//
//  ViewController.m
//  AreaPicker
//
//  Created by Mac on 16/9/13.
//  Copyright © 2016年 LoveSpending. All rights reserved.
//

#import "ViewController.h"
#import "NSString.h"

#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

//Pickerview
@property (strong, nonatomic) UIPickerView *myPicker;
@property (strong, nonatomic) UIView *pickerBgView;
@property (strong, nonatomic) UIView *maskView;
@property (strong, nonatomic) UIButton *ensureBt;
@property (strong, nonatomic) UIButton *cancelBt;

@property (strong, nonatomic) UITextField *province;
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //textField
    self.province = [[UITextField alloc] initWithFrame:(CGRectMake(10, 200, kScreen_Width-20, 40))];
    self.province.placeholder = @"请选择地区";
    self.province.delegate = self;
    self.province.textAlignment = NSTextAlignmentCenter;
    self.province.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.province];
    
    [self getPickerData];
    [self pickewView];
    
}

- (void)pickewView{

    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, s_v_width, s_v_height)];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    
    self.pickerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, s_v_height*2/3-40, s_v_width, s_v_height+40)];
    self.pickerBgView.backgroundColor = [UIColor whiteColor];
    
    //选择器
    self.myPicker = [[UIPickerView alloc] initWithFrame:(CGRectMake(0, 40, s_v_width, s_v_height/3))];
    self.myPicker.dataSource = self;
    self.myPicker.delegate = self;
    self.myPicker.backgroundColor = [UIColor whiteColor];
    self.myPicker.userInteractionEnabled = YES;
    [self.pickerBgView addSubview:self.myPicker];
    
    //确定
    self.ensureBt = [[UIButton alloc] initWithFrame:(CGRectMake(15, 10, 50, 20))];
    [self.ensureBt setTitle:@"确定" forState:UIControlStateNormal];
    [self.ensureBt setTitleColor:[UIColor colorWithRed:1 green:0.15 blue:0.325 alpha:1] forState:UIControlStateNormal];
    [self.ensureBt addTarget:self action:@selector(ensure:) forControlEvents:UIControlEventTouchUpInside];
    self.ensureBt.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.pickerBgView addSubview:self.ensureBt];
    
    //取消
    self.cancelBt = [[UIButton alloc] initWithFrame:(CGRectMake(s_v_width-65, 10, 50, 20))];
    [self.cancelBt setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBt setTitleColor:[UIColor colorWithRed:1 green:0.15 blue:0.325 alpha:1] forState:UIControlStateNormal];
    [self.cancelBt addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelBt.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.pickerBgView addSubview:self.cancelBt];

}


- (void)getPickerData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }

}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
   
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
   
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    self.maskView.alpha = 0;
    self.pickerBgView.frame = CGRectMake(0, s_v_height, s_v_width, s_v_height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.pickerBgView.frame = CGRectMake(0, s_v_height*2/3-40, s_v_width, s_v_height+40);
    }];

    
    return NO;
}

- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.maskView.alpha = 0;
        self.pickerBgView.frame = CGRectMake(0, s_v_height, s_v_width, s_v_height);
        
    } completion:^(BOOL finished) {
        
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}

#pragma mark -buttonAction

- (void)cancel:(UIButton *)sender {
    [self hideMyPicker];
}

- (void)ensure:(UIButton *)sender {
    self.province.hidden = NO;
    
    NSString *province = [self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
    NSString *city = [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1]];
    
    NSString *town = [self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]];
    
    self.province.text = [NSString stringWithFormat:@"%@,%@,%@",province,city,town];
    
    
    [self hideMyPicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
