//
//  ViewController.m
//  GPlusTableBiewDemo
//
//  Created by Omar on 10/4/12.
//  Copyright (c) 2012 InfusionApps. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+BottomAnimation.h"

@interface ViewController ()
{
    NSMutableArray *arr;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    arr = [[NSMutableArray alloc] init];
    
    [arr addObject:@"1"];
    [arr addObject:@"2"];
    
    [table reloadData];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)addNew:(id)sender
{
    NSArray *additions = [NSArray arrayWithObject:
                          [NSIndexPath indexPathForRow:arr.count
                                             inSection:0]];
    [table beginUpdates];
    [table insertRowsAtIndexPaths:additions
                 withRowAnimation:UITableViewRowAnimationFromBottom];
    
    [arr addObject:@"new"];
    [table endUpdates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"channelsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    

    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row == 0)
//        return;
    

}
@end
