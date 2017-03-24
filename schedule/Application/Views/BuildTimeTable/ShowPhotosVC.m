//
//  ShowPhotosVC.m
//  schedule
//
//  Created by Prince on 7/14/16.
//  Copyright © 2016 Pavel. All rights reserved.
//

#import "ShowPhotosVC.h"
#import "PhotoCell.h"

@interface ShowPhotosVC () {
    NSArray *subjects;
    NSArray *photoPaths;
}

@end

@implementation ShowPhotosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    subjects = appController.subjects;
    downPicker = [[DownPicker alloc] initWithTextField:self.txtSubject withData:subjects];
    [downPicker addTarget:self
                   action:@selector(dp_Selected:)
         forControlEvents:UIControlEventValueChanged];
    
    photoPaths = [[NSArray alloc] init];
    self.photoTable.delegate = self;
    self.photoTable.dataSource = self;
}

-(void)dp_Selected:(id)dp {
    NSString* selectedValue = [downPicker text];
    photoPaths = [commonUtils loadImage:selectedValue];
    [self.photoTable reloadData];
    NSLog(@"%@", selectedValue);
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return photoPaths.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell *cell = (PhotoCell *)[tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];

    UIImage* image = [UIImage imageWithContentsOfFile:[photoPaths objectAtIndex:indexPath.row]];
    cell.image.image = [UIImage imageWithCGImage:image.CGImage];
    return cell;
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES]; 
}
@end
