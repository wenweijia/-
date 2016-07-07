//
//  StoreAccount.m
//  jobCompany
//
//  Created by 陈广川 on 16/1/5.
//  Copyright © 2016年 liaolx. All rights reserved.
//

#import "AccountPasswordMannger.h"
#import <SSKeychain/SSKeychain.h>

#define kService @"com.eshineTech.JyBsem"
#define kAccount @"account"
#define KuserProp @"userProp"

@implementation AccountPasswordMannger

+ (void)SaveAccount:(NSString *)account andPassword:(NSString *)password andUserProp:(NSNumber *)userProp
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:account forKey:kAccount];
    [defaults setObject:userProp forKey:KuserProp];
    [defaults synchronize];
    [SSKeychain setPassword:password forService:kService account:account];
}

+ (NSDictionary *)GetAccountAndPassword {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *account = [defaults objectForKey:kAccount];
    if (account) {
        NSString *password = [SSKeychain passwordForService:kService account:account] ? [SSKeychain passwordForService:kService account:account] : @"";
        return @{account:password};
    } else {
        return @{@"": @""};
    }
}

+ (NSDictionary *)GetAccountAndUserProp {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *account = [defaults objectForKey:kAccount];
    NSString *userProp = [defaults objectForKey:KuserProp];
    if (account) {
        return @{account:userProp};
    } else {
        return @{@"": @""};
    }
}

+ (BOOL)ClearPassWord {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults objectForKey:kAccount] ? [userDefaults objectForKey:kAccount] : @"";
    
    NSError *error;
    
    [SSKeychain deletePasswordForService:kService account:account error:&error];
    
    if (error) {
        return NO;
    } else {
        return YES;
    }
}


+(BOOL)DeletePassWithAcount:(NSString*)acount
{
    NSError *error;
    
    [SSKeychain deletePasswordForService:kService account:acount error:&error];
    
    if (error) {
        return NO;
    } else {
        return YES;
    }
 
}

@end
