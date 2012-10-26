//
//  CLViewController.h
//  iAutoMap
//
//  Created by Oleg Kalashnik on 26.10.12.
//  Copyright (c) 2012 Oleg Kalashnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CLViewController : UIViewController <MKMapViewDelegate, UIActionSheetDelegate>
{
    IBOutlet MKMapView * mapView_;
    
    NSMutableArray *annotationsArray_;
    
    CLLocationCoordinate2D currentCoordinate_;
}
@property(nonatomic, retain)IBOutlet MKMapView * mapView;
@end
