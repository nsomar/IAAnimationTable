//
//  IAAnimationTable.m
//  GPlusTableBiewDemo
//
//  Created by Omar on 10/4/12.
//  Copyright (c) 2012 InfusionApps. All rights reserved.
//

#import "UITableView+BottomAnimation.h"
#import "JRSwizzle.h"
#import "objc/runtime.h"

@implementation UITableView (TableViewRowAnimationFromBottom)

+ (void)initialize
{
    [UITableView
     jr_swizzleMethod:@selector(swizzled_createPreparedCellForGlobalRow:withIndexPath:)
     withMethod:@selector(_createPreparedCellForGlobalRow:withIndexPath:) error:nil];
    
    [UITableView
     jr_swizzleMethod:@selector(swizzled_insertRowsAtIndexPaths:withRowAnimation:)
     withMethod:@selector(insertRowsAtIndexPaths:withRowAnimation:) error:nil];
}

- (id) swizzled_createPreparedCellForGlobalRow:(int)globalRow withIndexPath:(NSIndexPath*)path
{
    [UITableView
     jr_swizzleMethod:@selector(_createPreparedCellForGlobalRow:withIndexPath:)
     withMethod:@selector(swizzled_createPreparedCellForGlobalRow:withIndexPath:)
     error:nil];
    
    UIView *cellView = [self swizzled_createPreparedCellForGlobalRow:globalRow withIndexPath:path];
    
    [UITableView
     jr_swizzleMethod:@selector(_createPreparedCellForGlobalRow:withIndexPath:)
     withMethod:@selector(swizzled_createPreparedCellForGlobalRow:withIndexPath:)
     error:nil];
    
    BOOL isFromBottomAnimation = [objc_getAssociatedObject(self,
                                                           "isFromBottomAnimation")
                                  boolValue];
    
    if(isFromBottomAnimation)
    {
        CGRect rect = cellView.frame;
        cellView.frame = CGRectMake(0, 500, 320, 44);
        [UIView animateWithDuration:.5 animations:^{
            cellView.frame = rect;
        }];
        
        isFromBottomAnimation = NO;
    }
    
    return cellView;
}

- (void)swizzled_insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [UITableView
     jr_swizzleMethod:@selector(swizzled_insertRowsAtIndexPaths:withIndexPath:)
     withMethod:@selector(insertRowsAtIndexPaths:withRowAnimation::) error:nil];
    
    [self swizzled_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
    [UITableView
     jr_swizzleMethod:@selector(swizzled_insertRowsAtIndexPaths:withIndexPath:)
     withMethod:@selector(insertRowsAtIndexPaths:withRowAnimation::) error:nil];
    
    BOOL isFromBottomAnimation = animation == UITableViewRowAnimationFromBottom;
    
    objc_setAssociatedObject(self, "isFromBottomAnimation",
                             [NSNumber numberWithBool:isFromBottomAnimation], OBJC_ASSOCIATION_ASSIGN);
}

@end
