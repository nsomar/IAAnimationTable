//
//  ViewController.h
//  GPlusTableBiewDemo
//
//  Created by Omar on 10/4/12.
//  Copyright (c) 2012 InfusionApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *table;
}
@end
