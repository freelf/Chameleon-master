#import <Foundation/Foundation.h>

@interface LPMessage : NSObject
{
    short type;
    short command;
    NSData* data;
    long linkid;
    long modeid;
	int playerid;
	NSString* Adid;
}

-(void) setType : (short) _type;

-(short) getType;

-(void) setCommand : (short) _command;

-(short) getCommand;

-(void) setData : (NSData*) _data;

-(NSData*) getData;

-(long) getLinkid;

-(void) setLinkid : (long) _linkid;

-(long) getModeid;

-(void) setModeid : (long) _modeid;

-(void) setPlayerid:(int) _playerid;

-(int) getPlayerid;

-(NSString*) getAdid;

-(void) setAdid : (NSString*) _adid;

@end