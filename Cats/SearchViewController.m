//
//  SearchViewController.m
//  Cats
//
//  Created by carmen cheng on 2016-11-22.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tagTextField;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (IBAction)saveButton:(id)sender {
    NSString *inputTags = self.tagTextField.text;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:inputTags, @"foo", nil];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSNotification *notify = [[NSNotification alloc]initWithName:@"newTags" object:sender userInfo:dict];
    [center postNotification:notify];
    [self dismissViewControllerAnimated:YES completion:nil];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
