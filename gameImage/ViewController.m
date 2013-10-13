//
//  ViewController.m
//  gameImage
//
//  Created by linhnguyen on 10/9/13.
//  Copyright (c) 2013 viettel. All rights reserved.
//

#import "ViewController.h"
#import "CustomImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    itemSelected = -1;
    arrayNameImage = [[NSMutableArray alloc] init];
    [arrayNameImage addObject:@"img_1.png"];
    [arrayNameImage addObject:@"img_2.png"];
    [arrayNameImage addObject:@"img_3.png"];
    [arrayNameImage addObject:@"img_4.png"];
    [arrayNameImage addObject:@"img_5.png"];
    [arrayNameImage addObject:@"img_6.png"];
    [arrayNameImage addObject:@"img_7.png"];
    [arrayNameImage addObject:@"img_8.png"];
    [arrayNameImage addObject:@"img_9.png"];
    [arrayNameImage addObject:@"img_10.png"];
    [arrayNameImage addObject:@"img_1.png"];
    [arrayNameImage addObject:@"img_2.png"];
    [arrayNameImage addObject:@"img_3.png"];
    [arrayNameImage addObject:@"img_4.png"];
    [arrayNameImage addObject:@"img_5.png"];
    [arrayNameImage addObject:@"img_6.png"];
    [arrayNameImage addObject:@"img_7.png"];
    [arrayNameImage addObject:@"img_8.png"];
    [arrayNameImage addObject:@"img_9.png"];
    [arrayNameImage addObject:@"img_10.png"];
    
    int numberItem = arrayNameImage.count;
    
    while (numberItem > 0) {
        NSInteger index = arc4random() % numberItem;
        NSString *item = [arrayNameImage objectAtIndex:index];
        
        [arrayNameImage addObject:item];
        [arrayNameImage removeObjectAtIndex:index];
        
        numberItem --;
    }
    NSLog(@"%@", arrayNameImage);
//    NSLog(@"%d", arrayNameImage.count);
//    

    int t = 0;
    int j = 0, i = 0;
    for (NSString *Str in arrayNameImage) {
        if (t == 4) {
            j ++;
            t = 0;
        }
        UIView *viewItem = [[UIView alloc] initWithFrame:CGRectMake(t * 80 , 28 + j * 80, 80, 80)];
        [viewItem setTag:i + 100];
        
        CustomImage *imageItem = [[CustomImage alloc] initWithFrame:CGRectMake(2.5, 2.5, viewItem.frame.size.width - 5, viewItem.frame.size.height - 5)];
        [imageItem setImage:[UIImage imageNamed:Str]];
        [viewItem addSubview:imageItem];
        
      
        UIButton *buttonItem = [[UIButton alloc] initWithFrame:CGRectMake(2.5, 2.5, viewItem.frame.size.width - 5, viewItem.frame.size.height - 5)];
        [buttonItem addTarget:self action:@selector(openImage:) forControlEvents:UIControlEventTouchUpInside];
        [buttonItem setTag: i + 1];
        [buttonItem setBackgroundColor:[UIColor clearColor]];

        [viewItem addSubview:buttonItem];
        [self.view addSubview:viewItem];

        [buttonItem release];
        [imageItem release];
        [viewItem release];
               
        t ++;
        i ++;
    }
    
    [self performSelector:@selector(setBackground) withObject:self afterDelay:2];
}

- (void) setBackground{

    for (int i = 0; i < arrayNameImage.count; i ++) {
        [[[self.view viewWithTag:i + 100] viewWithTag:i + 1] setBackgroundColor:[UIColor grayColor]];
    }
}

- (void) openImage: (UIButton *) btn {

    int index = btn.tag -1;
    NSLog(@"Index = %d", index);

    [btn setBackgroundColor:[UIColor clearColor]];
    if (itemSelected < 0) {
        itemSelected = index;
        return;
    }
    if (index == (itemSelected)) {
        itemSelected = index;
        return;
    }
    
    //itemSelected = btn.tag -1;
    NSString *str1 = [arrayNameImage objectAtIndex:btn.tag - 1];
    NSString *str2 = [arrayNameImage objectAtIndex:itemSelected];
    NSLog(@"str1: %@ str2: %@", str1, str2);
    if ([str1 isEqualToString:str2]) {
        
        [[[self.view viewWithTag:itemSelected + 100] viewWithTag:itemSelected + 1] setBackgroundColor:[UIColor yellowColor]];
        [((UIButton *)[[self.view viewWithTag:itemSelected + 100] viewWithTag:itemSelected + 1]) setEnabled:NO];
        
//        [UIView animateWithDuration:3.5 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
//            [[[self.view viewWithTag:btn.tag  + 100 - 1] viewWithTag:btn.tag] setBackgroundColor:[UIColor clearColor]];
//            [((UIButton *)[[self.view viewWithTag:btn.tag  + 100 - 1] viewWithTag:btn.tag]) setEnabled:NO];
//        } completion:^(BOOL isfinished){
//            [[[self.view viewWithTag:btn.tag  + 100 - 1] viewWithTag:btn.tag] setBackgroundColor:[UIColor yellowColor]];
//
//        }];
        
        [UIView transitionWithView:[self.view viewWithTag:btn.tag  + 100 - 1] duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            
            CustomImage *imageItem = [[CustomImage alloc] initWithFrame:CGRectMake(2.5, 2.5, [self.view viewWithTag:btn.tag  + 100 - 1].frame.size.width - 5, [self.view viewWithTag:btn.tag  + 100 - 1].frame.size.height - 5)];
            [imageItem setImage:[UIImage imageNamed:[arrayNameImage objectAtIndex:btn.tag - 1]]];
            [[self.view viewWithTag:btn.tag  + 100 - 1] addSubview:imageItem];
            [imageItem removeFromSuperview];
            
        } completion:^(BOOL finished){
            //isFrontFace = YES;
            [[[self.view viewWithTag:btn.tag  + 100 - 1] viewWithTag:btn.tag] setBackgroundColor:[UIColor yellowColor]];
        }];
        
        [UIView transitionWithView:[self.view viewWithTag:itemSelected + 100] duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            
            CustomImage *imageItem = [[CustomImage alloc] initWithFrame:CGRectMake(2.5, 2.5, [self.view viewWithTag:itemSelected + 100].frame.size.width - 5, [self.view viewWithTag:itemSelected + 100].frame.size.height - 5)];
            [imageItem setImage:[UIImage imageNamed:[arrayNameImage objectAtIndex:btn.tag - 1]]];
            [[self.view viewWithTag:itemSelected + 100] addSubview:imageItem];
            [imageItem removeFromSuperview];
            
        } completion:^(BOOL finished){
            //isFrontFace = YES;
            [[[self.view viewWithTag:itemSelected + 100] viewWithTag:itemSelected + 1] setBackgroundColor:[UIColor yellowColor]];
        }];

        itemSelected = -1;
    
    } else
        itemSelected = -1;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
