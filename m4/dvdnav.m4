dnl Configure paths for DVDNAV
dnl
dnl Copyright (C) 2001 Daniel Caujolle-Bert <segfault@club-internet.fr>
dnl  
dnl This program is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; either version 2 of the License, or
dnl (at your option) any later version.
dnl  
dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl  
dnl You should have received a copy of the GNU General Public License
dnl along with this program; if not, write to the Free Software
dnl Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
dnl  
dnl  
dnl As a special exception to the GNU General Public License, if you
dnl distribute this file as part of a program that contains a configuration
dnl script generated by Autoconf, you may include it under the same
dnl distribution terms that you use for the rest of that program.
dnl  

dnl AM_PATH_DVDNAV([MINIMUM-VERSION, [ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND ]]])
dnl Test for DVDNAV, and define DVDNAV_CFLAGS and DVDNAV_LIBS
dnl
AC_DEFUN([AM_PATH_DVDNAV],
[dnl 
dnl Get the cflags and libraries from the dvdnav-config script
dnl
AC_ARG_WITH(dvdnav-prefix,
    [  --with-dvdnav-prefix=PFX  Prefix where DVDNAV is installed (optional)],
            dvdnav_config_prefix="$withval", dvdnav_config_prefix="")
AC_ARG_WITH(dvdnav-exec-prefix,
    [  --with-dvdnav-exec-prefix=PFX                                                                             Exec prefix where DVDNAV is installed (optional)],
            dvdnav_config_exec_prefix="$withval", dvdnav_config_exec_prefix="")
AC_ARG_ENABLE(dvdnavtest, 
    [  --disable-dvdnavtest      Do not try to compile and run a test DVDNAV program],, enable_dvdnavtest=yes)

  if test x$dvdnav_config_exec_prefix != x ; then
     dvdnav_config_args="$dvdnav_config_args --exec-prefix=$dvdnav_config_exec_prefix"
     if test x${DVDNAV_CONFIG+set} != xset ; then
        DVDNAV_CONFIG=$dvdnav_config_exec_prefix/bin/dvdnav-config
     fi
  fi
  if test x$dvdnav_config_prefix != x ; then
     dvdnav_config_args="$dvdnav_config_args --prefix=$dvdnav_config_prefix"
     if test x${DVDNAV_CONFIG+set} != xset ; then
        DVDNAV_CONFIG=$dvdnav_config_prefix/bin/dvdnav-config
     fi
  fi

  min_dvdnav_version=ifelse([$1], ,0.5.0,$1)
  if test "x$enable_dvdnavtest" != "xyes" ; then
    AC_MSG_CHECKING([for DVDNAV-LIB version >= $min_dvdnav_version])
  else
    AC_PATH_PROG(DVDNAV_CONFIG, dvdnav-config, no)
    AC_MSG_CHECKING([for DVDNAV-LIB version >= $min_dvdnav_version])
    no_dvdnav=""
    if test "$DVDNAV_CONFIG" = "no" ; then
      no_dvdnav=yes
    else
      DVDNAV_CFLAGS=`$DVDNAV_CONFIG $dvdnav_config_args --cflags`
      DVDNAV_LIBS=`$DVDNAV_CONFIG $dvdnav_config_args --libs`
      dvdnav_config_major_version=`$DVDNAV_CONFIG $dvdnav_config_args --version | \
             sed 's/\([[0-9]]*\).\([[0-9]]*\).\([[0-9]]*\)/\1/'`
      dvdnav_config_minor_version=`$DVDNAV_CONFIG $dvdnav_config_args --version | \
             sed 's/\([[0-9]]*\).\([[0-9]]*\).\([[0-9]]*\)/\2/'`
      dvdnav_config_sub_version=`$DVDNAV_CONFIG $dvdnav_config_args --version | \
             sed 's/\([[0-9]]*\).\([[0-9]]*\).\([[0-9]]*\)/\3/'`
      dnl    if test "x$enable_dvdnavtest" = "xyes" ; then
      ac_save_CFLAGS="$CFLAGS"
      ac_save_LIBS="$LIBS"
      CFLAGS="$CFLAGS $DVDNAV_CFLAGS"
      LIBS="$DVDNAV_LIBS $LIBS"
dnl
dnl Now check if the installed DVDNAV is sufficiently new. (Also sanity
dnl checks the results of dvdnav-config to some extent
dnl
      AC_LANG_SAVE()
      AC_LANG_C()
      rm -f conf.dvdnavtest
      AC_TRY_RUN([
#include <dvdnav.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int 
main ()
{
  int major, minor, sub;
   char *tmp_version;

  system ("touch conf.dvdnavtest");

  return 0;
}
],, no_dvdnav=yes,[echo $ac_n "cross compiling; assumed OK... $ac_c"])
       CFLAGS="$ac_save_CFLAGS"
       LIBS="$ac_save_LIBS"
     fi
    fi
    if test "x$no_dvdnav" = x ; then
       AC_MSG_RESULT(yes)
       ifelse([$2], , :, [$2])     
    else
      AC_MSG_RESULT(no)
      if test "$DVDNAV_CONFIG" = "no" ; then
        echo "*** The dvdnav-config script installed by DVDNAV could not be found"
        echo "*** If DVDNAV was installed in PREFIX, make sure PREFIX/bin is in"
        echo "*** your path, or set the DVDNAV_CONFIG environment variable to the"
        echo "*** full path to dvdnav-config."
      else
        if test -f conf.dvdnavtest ; then
          :
        else
          echo "*** Could not run DVDNAV test program, checking why..."
          CFLAGS="$CFLAGS $DVDNAV_CFLAGS"
          LIBS="$LIBS $DVDNAV_LIBS"
          AC_TRY_LINK([
#include <dvdnav.h>
#include <stdio.h>
],      [ return 0; ],
        [ echo "*** The test program compiled, but did not run. This usually means"
          echo "*** that the run-time linker is not finding DVDNAV or finding the wrong"
          echo "*** version of DVDNAV. If it is not finding DVDNAV, you'll need to set your"
          echo "*** LD_LIBRARY_PATH environment variable, or edit /etc/ld.so.conf to point"
          echo "*** to the installed location  Also, make sure you have run ldconfig if that"
          echo "*** is required on your system"
	  echo "***"
          echo "*** If you have an old version installed, it is best to remove it, although"
          echo "*** you may also be able to get things to work by modifying LD_LIBRARY_PATH"
          echo "***"],
        [ echo "*** The test program failed to compile or link. See the file config.log for the"
          echo "*** exact error that occured. This usually means DVDNAV was incorrectly installed"
          echo "*** or that you have moved DVDNAV since it was installed. In the latter case, you"
          echo "*** may want to edit the dvdnav-config script: $DVDNAV_CONFIG" ])
          CFLAGS="$ac_save_CFLAGS"
          LIBS="$ac_save_LIBS"
        fi
      fi
    DVDNAV_CFLAGS=""
    DVDNAV_LIBS=""
    ifelse([$3], , :, [$3])
  fi
  AC_SUBST(DVDNAV_CFLAGS)
  AC_SUBST(DVDNAV_LIBS)
  AC_LANG_RESTORE()
  rm -f conf.dvdnavtest
])