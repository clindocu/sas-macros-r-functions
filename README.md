
sas-macros-r-functions
======================

**SAS macros** that are similar to useful **R functions**.

%colnames()
-----------

The SAS macro **%colnames()** generates a listing of *variable names* in the SAS log (vertically and horizontally).

The macro is similar to R base function **colnames()**.

In addition, the macro generates the dataset *qx_0000_ddt* in the library *work*, that contains the column number, *column name/variable name*, column label, column format, the length of the column name and the length of the label. 

The dataset includes flags for variable names that are greater than 8 characters or labels greater than 40 characters, which helps to quickly check if *SAS xpt specifications* are followed.

### Example


``` sas
%colnames(DM);
```

%gather()
---------

The SAS Macro **%gather()** transposes a dataset from *fat* to *skinny* (normalization) or from a *wide* to a *long* dataset.

The macro is similar to R function **tidyr:::gather()**.

The macro produces key/value pairs.

### Usage

``` sas
%gather(DbIn, Key, Value, Exclude, DbOut, ValFormat=, WithFormats=N);
```

NOTE: Option *WithFormats* executes the SAS function *fmtinfo()* that requires **SAS version 9.4** above!

```
DbIn:        input dataset
```

```
Key:         name of key variable in output (should not be a column name!)
```

```
Value:       name of variable with values in output (should not be a column name!)
```

```
Exclude:     is the -exclude variable (ID variable) - must be a column name
             (or more column names/primary keys, or empty)
```

```
DbOut:       output dataset
```

```
ValFormat:   Character format of variable with values (default character $200.)
             numeric formats not possible w/o NOTE: character values converted
             not possibe for (numeric) dates (dates as character only)
```

```
WithFormats: Output of the associated SAS Formats (e.g. char, num, time, date, datetime) in 
             Variable _ColForm and _ColTyp 
             (additional feature)
             Please Note: SAS function fmtinfo() requires SAS 9.4 above!
```

**Avoid SAS note**

SAS NOTE: *The quoted string currently being processed has become more than 262 characters long.
  You might have unbalanced quotation marks*
  
To avoid use:

``` sas
options noquotelenmax;
```

### Example

``` sas
%gather(VS_WIDE, VSTESTCD, VSORRES, SUBJID VISITNUM, VS_LONG, ValFormat=$10.);
```
