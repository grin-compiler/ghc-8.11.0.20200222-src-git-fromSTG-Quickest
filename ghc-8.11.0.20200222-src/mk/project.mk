# WARNING: mk/project.mk is automatically generated from mk/project.mk.in by
# ./configure.  Make sure you are editing mk/project.mk.in, not mk/project.mk.

################################################################################
#
# GHC Version
#

# ProjectVersion    is treated as a *string*
# ProjectVersionInt is treated as an *integer* (for cpp defines)

# Versioning scheme: A.B.C
#         A: major version, decimal, any number of digits
#         B: minor version, decimal, any number of digits
#     C: patchlevel, one digit, omitted if zero.
#
# ProjectVersionInt does *not* contain the patchlevel (rationale: this
# figure is used for conditional compilations, and library interfaces
# etc. are not supposed to change between patchlevels).
#
# The ProjectVersionInt is included in interface files, and GHC
# checks that it's reading interface generated by the same ProjectVersion
# as itself. It does this even though interface file syntax may not 
# change between versions.  Rationale: calling conventions or other 
# random .o-file stuff might change even if the .hi syntax doesn't

ProjectName       = The Glorious Glasgow Haskell Compilation System
ProjectTags       =
ProjectVersion    = 8.11.0.20200222$(ProjectTags)
ProjectVersionInt = 811
ProjectPatchLevel = 020200222
ProjectPatchLevel1 = 0
ProjectPatchLevel2 = 20200222
ProjectGitCommitId = 9d09411122b9b534b96e988b6d3f6d7eb04b8f66

################################################################################
#
#       Platform variables
#
################################################################################

# A "platform" is the GNU cpu-type/manufacturer/operating-system target machine
# specifier.  E.g. sparc-sun-solaris2
#
# Build  platform: the platform on which we are doing this build
# Host   platform: the platform on which these binaries will run
# Target platform: the platform for which this compiler will generate code
#
# We don't support build & host being different, because the build
# process creates binaries that are run during the build, and also
# installed.
#
# If host & target are different, then we are building a compiler
# which will generate intermediate .hc files to port to the target
# architecture for bootstrapping.  The libraries and stage 2 compiler
# will be built as HC files for the target system, and likely won't
# build on this host platform.
#
# An important invariant is that for any piece of source code, the
# platform on which the code is going to run is the HOST platform,
# and the platform on which we are building is the BUILD platform.
# Additionally for the compiler, the platform this compiler will
# generate code for is the TARGET.  TARGET is not meaningful outside
# the compiler sources.
#
# Guidelines for when to use HOST vs. TARGET:
#
#  - In the build system (Makefile, foo.mk), normally we should test
#    $(HOSTPLATFORM).  There are some cases (eg. installation), where
#    we expect $(HOSTPLATFORM)==$(TARGETPLATFORM), so in those cases it
#    doesn't matter which is used.
#
#  - In the compiler itself, we should test HOST or TARGET depending
#    on whether the conditional relates to the code being generated, or
#    the platform on which the compiler is running.  See the section
#    on "coding-style" in the commentary for more details.
#
#  - In all other code, we should be testing HOST only.
#
# NOTE: cross-compiling is not well supported by the build system.
# You have to do a lot of work by hand to cross compile: see the
# section on "Porting GHC" in the Building Guide.

HOSTPLATFORM            = x86_64-unknown-linux
TARGETPLATFORM          = x86_64-unknown-linux
BUILDPLATFORM           = x86_64-unknown-linux

HostPlatform_CPP        = x86_64_unknown_linux
HostArch_CPP            = x86_64
HostOS_CPP              = linux
HostVendor_CPP          = unknown

TargetPlatform_CPP      = x86_64_unknown_linux
TargetArch_CPP          = x86_64
TargetOS_CPP            = linux
TargetVendor_CPP        = unknown
LLVMTarget_CPP          = x86_64-unknown-linux

BuildPlatform_CPP       = x86_64_unknown_linux
BuildArch_CPP           = x86_64
BuildOS_CPP             = linux
BuildVendor_CPP         = unknown

x86_64_unknown_linux_HOST           = 1
x86_64_unknown_linux_TARGET       = 1
x86_64_unknown_linux_BUILD         = 1

x86_64_HOST_ARCH          = 1
x86_64_TARGET_ARCH      = 1
x86_64_BUILD_ARCH        = 1

linux_HOST_OS              = 1
linux_TARGET_OS          = 1
linux_BUILD_OS            = 1

unknown_HOST_VENDOR      = 1
unknown_TARGET_VENDOR  = 1
unknown_BUILD_VENDOR    = 1

################################################################################
#
#       Global configuration options
#
################################################################################

# Leading underscores on symbol names in object files
# Valid options: YES/NO
#
LeadingUnderscore=NO

# Pin a suffix on executables? If so, what (Windows only).
exeext0=
exeext1=
exeext2=
exeext3=
soext=.so

# Windows_Host=YES if on a Windows platform
ifneq "$(findstring $(HostOS_CPP), mingw32)" ""
Windows_Host=YES
else
Windows_Host=NO
endif

# Windows_Target=YES if we are targeting a Windows platform
ifneq "$(findstring $(TargetOS_CPP), mingw32)" ""
Windows_Target=YES
else
Windows_Target=NO
endif

# In case of Solaris OS, does it provide broken shared libs
# linker or not?
SOLARIS_BROKEN_SHLD=NO

# Is the stage0 compiler affected by Bug #9439?
GHC_LLVM_AFFECTED_BY_9439 = @GHC_LLVM_AFFECTED_BY_9439@

ifeq "$(TargetArch_CPP)" "arm"
ARM_ISA=
endif
