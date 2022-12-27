#ifndef _BUTTON_IMX6ULL_
#define _BUTTON_IMX6ULL_

struct Button_Imx6ull {
    int count;
    void (*init) (int whith);
    int (*read) (int whitch,char* buff,size_t size);
    int (*write) (int whitch,char* buff,size_t size);
};

void RegestButtonImx6ll(struct Button_Imx6ull* ptr);
void UnregestButtonImx6ll(struct Button_Imx6ull* ptr);

struct Button_Imx6ull* GetButtonImx6ull (void);


#endif
