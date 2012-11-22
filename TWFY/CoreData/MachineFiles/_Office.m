// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Office.m instead.

#import "_Office.h"

const struct OfficeAttributes OfficeAttributes = {
	.dept = @"dept",
	.from_date = @"from_date",
	.position = @"position",
	.to_date = @"to_date",
};

const struct OfficeRelationships OfficeRelationships = {
	.mp = @"mp",
};

const struct OfficeFetchedProperties OfficeFetchedProperties = {
};

@implementation OfficeID
@end

@implementation _Office

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Office" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Office";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Office" inManagedObjectContext:moc_];
}

- (OfficeID*)objectID {
	return (OfficeID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic dept;






@dynamic from_date;






@dynamic position;






@dynamic to_date;






@dynamic mp;

	






@end
