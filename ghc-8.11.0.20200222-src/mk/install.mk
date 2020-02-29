#								 -*-makefile-*-
# mk/install.mk.  Generated from install.mk.in by configure.
#
################################################################################
#
# install.mk.in
#
# This file sets up the installation directories.
#
# DO NOT EDIT THIS FILE!
#
# 	- install.mk is auto-generated from install.mk.in by configure.
#	  If you edit install.mk your changes will be spammed.
#
#	- Settings in this file may be overridden by giving replacement
#	  definitions in build.mk.

# Definition of installation directories, we don't use half of these, but since
# the configure script has them on offer while passing through, we might as well
# set them. Note that we have to be careful, because the GNU coding standards
# have changed a bit over the course of time, and autoconf development reflects
# this.
#
# A little bit of history regarding autoconf and GNU coding standards, use this
# as a cheat-sheet for the stuff below:
#
# variable    | default < 2.60     | default >= 2.60
# ------------+--------------------+--------------------------------------
# exec_prefix | ${prefix}          | ${prefix}
# libdir      | ${exec_prefix}/lib | ${exec_prefix}/lib
# datarootdir | NONE!              | ${prefix}/share
# datadir     | ${prefix}/share    | ${datarootdir}
# infodir     | ${prefix}/info     | ${datarootdir}/info
# mandir      | ${prefix}/man      | ${datarootdir}/man
# docdir      | NONE!              | ${datarootdir}/doc/${PACKAGE_TARNAME}
# htmldir     | NONE!              | ${docdir}
# dvidir      | NONE!              | ${docdir}
# pdfdir      | NONE!              | ${docdir}
# psdir       | NONE!              | ${docdir}
#
# NOTE: The default e.g. ${docdir} above means that autoconf substitutes the
# string "${docdir}", not the value of docdir! This is crucial for the GNU
# coding standards. See #1924.

define set_default
# $1 = variable to set
# $2 = default value to use, if configure didn't expand it
# If $1 starts with an @ then configure didn't set it (because a version
# of autoconf that is too old was used), so set it to a sensible value
ifneq "$$(filter @%,$$($1))" ""
$1 = $2
endif
endef

prefix          = /usr/local

datarootdir = ${prefix}/share
$(eval $(call set_default,datarootdir,$${prefix}/share))

exec_prefix     = ${prefix}
bindir          = ${exec_prefix}/bin
datadir         = ${datarootdir}
libdir          = ${exec_prefix}/lib
includedir      = ${prefix}/include
mandir          = ${datarootdir}/man

# Note that `./configure --docdir=/foo/bar` should work.
docdir = ${datarootdir}/doc/${PACKAGE_TARNAME}
PACKAGE_TARNAME = ghc-${ProjectVersion}
$(eval $(call set_default,docdir,$${datarootdir}/doc/$${PACKAGE_TARNAME}))

htmldir = ${docdir}
dvidir  = ${docdir}
pdfdir  = ${docdir}
psdir   = ${docdir}
$(eval $(call set_default,htmldir,$${docdir}))
$(eval $(call set_default,dvidir,$${docdir}))
$(eval $(call set_default,pdfdir,$${docdir}))
$(eval $(call set_default,psdir,$${docdir}))

ifeq "$(RelocatableBuild)" "YES"

# Hack: our directory layouts tend to be different on Windows, so
# hack around configure's bogus assumptions here.
datarootdir = $(prefix)
datadir     = $(prefix)/lib
libdir      = $(prefix)/lib

docdir    = $(prefix)/doc
htmldir   = $(docdir)
dvidir    = $(docdir)
pdfdir    = $(docdir)
psdir     = $(docdir)

ghclibdir = $(libdir)

else

# Unix: override libdir and datadir to put ghc-specific stuff in
# a subdirectory with the version number included.
ghclibdir     = $(libdir)/$(CrossCompilePrefix)ghc-$(ProjectVersion)
endif

ghclibexecdir = $(ghclibdir)
topdir        = $(ghclibdir)
ghcheaderdir  = $(ghclibdir)/include

#-----------------------------------------------------------------------------
# install configuration

#
# Set this to have files installed with a specific owner
#
INSTALL_OWNER =

# 
# Set this to have files installed with a specific group
#
INSTALL_GROUP =

#
# Invocations of `install' for the four different classes
# of targets:
#
CREATE_SCRIPT   = create () { touch "$$1" && chmod 755 "$$1" ; } && create
CREATE_DATA     = create () { touch "$$1" && chmod 644 "$$1" ; } && create

INSTALL_PROGRAM = $(INSTALL) -m 755
INSTALL_SCRIPT  = $(INSTALL) -m 755
INSTALL_SHLIB   = $(INSTALL) -m 755
INSTALL_DATA    = $(INSTALL) -m 644
INSTALL_HEADER  = $(INSTALL) -m 644
INSTALL_MAN     = $(INSTALL) -m 644
INSTALL_DOC     = $(INSTALL) -m 644
INSTALL_DIR     = $(INSTALL) -m 755 -d

# runhaskell and hsc2hs are special, in that other compilers besides
# GHC might provide them.  Systems with a package manager often come
# with tools to manage this kind of clash, e.g. RPM's
# update-alternatives.  When building a distribution for such a system,
# we recommend setting both of the following to 'YES'.
#
# NO_INSTALL_RUNHASKELL = YES
# NO_INSTALL_HSC2HS     = YES
#
# NB. we use negative tests here because for binary-distributions we cannot
# test build-time variables at install-time, so they must default to on.

ifneq "$(DESTDIR)" ""
override DESTDIR := $(abspath $(DESTDIR))
endif

