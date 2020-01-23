#ifndef DATABASE_HPP
#define DATABASE_HPP

#include <iostream>
#include <map>
#include <string>
#include <vector>

typedef struct Datum {
    typedef enum {
        Nothing,
        String,
        Scalar,
        Vector
    } type_t;

    type_t  type;
    std::string value;
    std::vector<std::vector<float> > data;
} Datum;

typedef std::map<std::string, Datum> Database;

std::ostream & operator<<(std::ostream &, const Datum &);
std::ostream & operator<<(std::ostream &, const Database &);

Database load(FILE * fid);

extern Database db;
#endif
