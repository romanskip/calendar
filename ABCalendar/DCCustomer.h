//
//  DCCustomer.h
//  ABCalendar
//
//  Created by SkIp on 18/06/14.
//  Copyright (c) 2014 Roman Ayala Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCCustomer : NSObject

	@property NSInteger *IdCustomer;
	@property NSString *Name;
	@property NSString *LastName;
	@property NSString *Mobile;
	@property NSString *Home;
	@property NSString *Work;
	@property NSString *Email;
	@property NSString *Street1;
	@property NSString *Street2;
	@property NSInteger *IdCity;
	@property NSInteger *IdState;
	@property NSString *Postal;
	@property NSString *Comments;
	@property NSInteger *IdCategory;
	@property NSInteger *IdReferral;
	@property Boolean *Active;
	/*@property Cities PK_Cities;
	@property States PK_States;
	@property Referrals PK_Referrals;
	@property Categories PK_Categories;
*/
@end
