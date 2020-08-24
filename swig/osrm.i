%module osrm

%{
#include <vector>
#include "swig_osrm.hpp"
%}

#ifdef SWIGJAVA
%include <swiginterface.i>
%include <enums.swg>
#endif

#ifdef SWIGPYTHON
#pragma GCC diagnostic ignored "-Wunused-parameter"
#endif

%include <stl.i>
%include <std_string.i>
%include <std_except.i>
%include <typemaps.i>

%pragma(java) jniclasscode=%{
    static {
        System.loadLibrary("swig_jni_bindings");
    }
%}

%ignore std::vector<Coordinate>::vector(size_type);
%ignore std::vector<Coordinate>::resize(size_type);
%template(CoordinateVector) std::vector<Coordinate>;

%ignore std::vector<Bearing>::vector(size_type);
%ignore std::vector<Bearing>::resize(size_type);
%template(BearingVector) std::vector<Bearing>;

%ignore std::vector<Radius>::vector(size_type);
%ignore std::vector<Radius>::resize(size_type);
%template(RadiusVector) std::vector<Radius>;

%template(LongVector) std::vector<long>;
%template(UnsignedLongVector) std::vector<unsigned long>;
%template(DoubleVector) std::vector<double>;

%include "swig_osrm.hpp"
