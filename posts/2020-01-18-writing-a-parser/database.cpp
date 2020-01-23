#include "database.hpp"

extern "C" FILE * yyin;
extern int yyparse();//void *);

Database db;

static const std::map<Datum::type_t, std::string> type2string = {
        {Datum::String, "string"},
        {Datum::Scalar, "scalar"},
        {Datum::Vector, "vector"}
};

std::ostream & operator<<(std::ostream & os, const Datum & datum)
{
    if (datum.type == Datum::Nothing)
        return os;

    os << type2string.at(datum.type) << ":";
    switch (datum.type)
    {
        case Datum::Scalar:
        case Datum::Vector:
            for (auto row = datum.data.begin(); row != datum.data.end(); row++)
            {
                if (row != datum.data.begin())
                    os << std::endl;

                for (auto col = row->begin(); col != row->end(); col++)
                    os << (col == row->begin() ? "" : " ") << *col;
            }
            break;
        case Datum::String:
            os << datum.value;
            break;
        default:
            // Sanity check for the impossible, but this means something
            // very wrong has happened…
            std::cerr << "Unknown datum type!" << std::endl;
            os.setstate(std::ios::failbit);
    }
    return os;
}

std::ostream & operator<<(std::ostream & os, const Database & db)
{
    for (auto entry: db)
    {
        os << entry.first << ":" << entry.second << std::endl;
        if (os.fail())
            return os;
    }
    return os;
}

Database load(FILE * fid)
{
    Database db;
    yyin = fid;
    int res = yyparse(); //(void *) &db);
    if (res != 0)
    {
        std::cerr << "Error loading database" << std::endl;
        db.clear();
    }
    return db;
}
