// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Constituency.m instead.

#import "_Constituency.h"

const struct ConstituencyAttributes ConstituencyAttributes = {
	.name = @"name",
};

const struct ConstituencyRelationships ConstituencyRelationships = {
	.mp = @"mp",
};

const struct ConstituencyFetchedProperties ConstituencyFetchedProperties = {
};

@implementation ConstituencyID
@end

@implementation _Constituency

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Constituency" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Constituency";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Constituency" inManagedObjectContext:moc_];
}

- (ConstituencyID*)objectID {
	return (ConstituencyID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic mp;

	






@end
