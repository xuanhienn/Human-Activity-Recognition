/*** Autogenerated by WIDL 7.0-rc2 from include/tpcshrd.idl - Do not edit ***/

#ifdef _WIN32
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 475
#endif
#include <rpc.h>
#include <rpcndr.h>
#endif

#ifndef COM_NO_WINDOWS_H
#include <windows.h>
#include <ole2.h>
#endif

#ifndef __tpcshrd_h__
#define __tpcshrd_h__

/* Forward declarations */

/* Headers for imported files */

#include <wtypes.h>

#ifdef __cplusplus
extern "C" {
#endif

#define TABLET_DISABLE_PRESSANDHOLD        0x00000001
#define TABLET_DISABLE_PENTAPFEEDBACK      0x00000008
#define TABLET_DISABLE_PENBARRELFEEDBACK   0x00000010
#define TABLET_DISABLE_TOUCHUIFORCEON      0x00000100
#define TABLET_DISABLE_TOUCHUIFORCEOFF     0x00000200
#define TABLET_DISABLE_TOUCHSWITCH         0x00008000
#define TABLET_DISABLE_FLICKS              0x00010000
#define TABLET_ENABLE_FLICKSONCONTEXT      0x00020000
#define TABLET_ENABLE_FLICKLEARNINGMODE    0x00040000
#define TABLET_DISABLE_SMOOTHSCROLLING     0x00080000
#define TABLET_DISABLE_FLICKFALLBACKKEYS   0x00100000
#define TABLET_ENABLE_MULTITOUCHDATA       0x01000000
#define WM_TABLET_QUERYSYSTEMGESTURESTATUS 0x02CC
#define IP_CURSOR_DOWN  0x1
#define IP_INVERTED     0x2
#define IP_MARGIN       0x4
typedef DWORD CURSOR_ID;
typedef USHORT SYSTEM_EVENT;
typedef DWORD TABLET_CONTEXT_ID;
#ifndef _XFORM_
#define _XFORM_
typedef struct tagXFORM {
    float eM11;
    float eM12;
    float eM21;
    float eM22;
    float eDx;
    float eDy;
} XFORM;
#endif
/* Begin additional prototypes for all interfaces */


/* End additional prototypes */

#ifdef __cplusplus
}
#endif

#endif /* __tpcshrd_h__ */
