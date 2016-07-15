//
//  PMLocationPickerController.m
//  ProjectMenu
//
//  Created by Abbin Varghese on 15/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PMLocationPickerController.h"
#import "NSDictionary+PMPlace.h"

@interface PMLocationPickerController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray *placesArray;

@property (weak, nonatomic) IBOutlet UITableView *placesTableview;
@property (weak, nonatomic) IBOutlet UITextField *searchField;

@end

@implementation PMLocationPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_searchField becomeFirstResponder];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _placesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *place = _placesArray[indexPath.row];
    NSArray *terms = place[@"terms"];
    NSString *text = terms[0][@"value"];
    NSString *detailed = [NSString stringWithFormat:@"%@ %@",terms[1][@"value"],terms[2][@"value"]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PMLocationPickerTableViewCell"];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailed;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *key = @"AIzaSyB_qAFXN7d7OX_GgDkKuHFblpkrgawPXV0";
        NSDictionary *place = _placesArray[indexPath.row];
        NSString *placeId = place[@"place_id"];
        NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",placeId,key];
        NSURL *googleRequestURL=[NSURL URLWithString:url];
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        if (data) {
            NSError* error;
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  
                                  options:kNilOptions
                                  error:&error];
            
            NSMutableDictionary *placeDetail = [[NSMutableDictionary alloc]initWithPlace:[json objectForKey:@"result"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_searchField resignFirstResponder];
                [self dismissViewControllerAnimated:YES completion:^{
                    if ([self.delegate respondsToSelector:@selector(PMLocationPickerControllerFinishedWithPlace:)]) {
                        [self.delegate PMLocationPickerControllerFinishedWithPlace:placeDetail];
                    }
                }];
            });

        }
        
    });

}

- (IBAction)textFieldEditingChanged:(UITextField *)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *inputString = sender.text;
        NSString *type = @"(cities)";
        NSString *key = @"AIzaSyB_qAFXN7d7OX_GgDkKuHFblpkrgawPXV0";
        
        NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
        NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
        
        NSString *component = [NSString stringWithFormat:@"country:%@",countryCode];
        
        NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=%@&components=%@&key=%@",inputString,type,component,key];
        NSURL *googleRequestURL=[NSURL URLWithString:url];
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        
        if (data) {
            NSError* error;
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  
                                  options:kNilOptions
                                  error:&error];
            _placesArray = [json objectForKey:@"predictions"];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_placesTableview reloadData];
        });
    });

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchField resignFirstResponder];
}

- (IBAction)dismissView:(id)sender {
    [_searchField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
