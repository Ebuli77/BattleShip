#ifndef STATUS_H
#define STATUS_H

namespace Status
{

enum StatusEnum {
    Initialising,
    Ready,
    MyTurn,
    GameOver
};

enum Role {
    Client,
    Server
};

enum AmmoType {
    Normal = 1,
    Bomb = 5
};

struct Shot {
    int coordx;
    int coordy;
    AmmoType ammo;
};

enum LoadInfo {
    Data,
    Shooting,
    Greeting,
    GameEnded
};

struct Protocol
{
    LoadInfo type;
    Shot shot; // Always there, data used if protocol type equals "Shooting"
    //char data[128];
};
}
#endif // STATUS_H
