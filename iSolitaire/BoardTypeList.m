//
//  BoardTypeList.m
//  SolitaireObjC
//
//  Created by Fabien BELLANGER on 15/09/2014.
//  Copyright (c) 2014 Fabien BELLANGER. All rights reserved.
//

#import "BoardTypeList.h"
#import "BoardType.h"

@interface BoardTypeList()

@property (nonatomic) NSMutableArray *privateTypes;

@end


@implementation BoardTypeList

/**
 * Initialisation publique
 *
 */
+ (instancetype) initList
{
	static BoardTypeList *types;
	
	if (!types)
	{
		types = [[self alloc] initPrivate];
	}
	
	return types;
}


/**
 * Initialisation classique
 *
 */
- (instancetype) init
{
	@throw [NSException exceptionWithName: @"Singleton"
																 reason: @"Use +[BoardTypeList initList]"
															 userInfo: nil];
	return nil;
}


/**
 * Initialisation privée
 *
 */
- (instancetype) initPrivate
{
	self = [super init];
	if (self)
	{
		_privateTypes = [[NSMutableArray alloc] init];
		[self addEnglishBoardType];
		[self addFrenchBoardType];
		[self addEuropeanBoardType];
		[self addTestBoardType];
	}
	return self;
}


/**
 * Liste de tous les types de plateaux
 *
 */
- (NSArray *) getAllTypes
{
	return [_privateTypes copy];
}


/**
 * Ajout d'un type de plateau
 *
 */
- (void) addBoardType:(NSString *)name
								 grid:(NSMutableArray *)grid
{
	BoardType *boardType = [[BoardType alloc] initWithParams:name grid:grid];
	
	[_privateTypes addObject: boardType];
}

/**
 * Retourne le plateau initial
 *
 */
- (NSMutableArray *) getArrayOfType:(NSString *)type
{
	if ([type isEqualToString:@"Anglais"])
		return [self getArrayEnglishBoard];
	else if ([type isEqualToString:@"Français"])
		return [self getArrayFrenchBoard];
	else if ([type isEqualToString:@"Européen"])
		return [self getArrayEuropeanBoard];
	else if ([type isEqualToString:@"Test"])
		return [self getArrayTestBoard];
	else
		return [[NSMutableArray alloc] init];
}


/**
 * Plateau anglais
 *
 */
- (void) addEnglishBoardType
{
	[self addBoardType:@"Anglais" grid:[self getArrayEnglishBoard]];
}

/**
 * Plateau français
 *
 */
- (void) addFrenchBoardType
{
	[self addBoardType:@"Français" grid:[self getArrayFrenchBoard]];
}

/**
 * Plateau européen
 *
 */
- (void) addEuropeanBoardType
{
	[self addBoardType:@"Européen" grid:[self getArrayEuropeanBoard]];
}

/**
 * Plateau test
 *
 */
- (void) addTestBoardType
{
	[self addBoardType:@"Test" grid:[self getArrayTestBoard]];
}

// =================================================================================================
//
// Définition des plateaux de jeu
//
// =================================================================================================
/**
 * Tableau - Anglais
 *
 */
- (NSMutableArray *) getArrayEnglishBoard
{
	NSMutableArray *grid = [[NSMutableArray alloc] initWithArray:
													@[[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"1",@"1",@"1",@"0",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"1",@"1",@"1",@"0",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"2",@"1",@"1",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"1",@"1",@"1",@"0",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"1",@"1",@"1",@"0",@"0"]]]];
	
	return grid;
}

/**
 * Tableau - Français
 *
 */
- (NSMutableArray *) getArrayFrenchBoard
{
	NSMutableArray *grid = [[NSMutableArray alloc] initWithArray:
													@[[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"1",@"1",@"1",@"0",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"1",@"1",@"1",@"1",@"1",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"2",@"1",@"1",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"1",@"1",@"1",@"1",@"1",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"1",@"1",@"1",@"0",@"0"]]]];
	
	return grid;
}

/**
 * Tableau - Européen
 *
 */
- (NSMutableArray *) getArrayEuropeanBoard
{
	NSMutableArray *grid = [[NSMutableArray alloc] initWithArray:
													@[[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"1",@"1",@"1",@"0",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"1",@"1",@"1",@"1",@"1",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"2",@"1",@"1",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"1",@"1",@"1",@"1",@"1",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"1",@"1",@"1",@"0",@"0"]]]];
	
	return grid;
}

/**
 * Tableau - Test
 *
 */
- (NSMutableArray *) getArrayTestBoard
{
	NSMutableArray *grid = [[NSMutableArray alloc] initWithArray:
													@[[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"2",@"2",@"2",@"0",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"2",@"2",@"2",@"0",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"2",@"2",@"2",@"0",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"1",@"1",@"2",@"2",@"2",@"2",@"1"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"2",@"2",@"2",@"0",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"2",@"2",@"2",@"0",@"0"]],
														[[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"2",@"2",@"2",@"0",@"0"]]]];
	
	return grid;
}

@end
