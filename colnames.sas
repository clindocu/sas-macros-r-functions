********************************************************************;
********** SAS Macro %colnames(): List of Variable Names like R base Function: colnames();
********** 1) Vertical output in SAS log;
********** 2) Horizontal output in SAS log: like R;
********** 3) Dataset with col names, labels, formats: like e.g: 
**********    df1 <- as.data.frame(colnames(DM)) # df with col names only;
**********    SAS dataset name: qx_0000_ddt;
********** 4) Flags for variable names > 8 char. and/or labels > 40 char.;
**********    (SAS XPT specifications!);
********** Example: %colnames(MyDataSet);
********************************************************************;
%macro colnames(DbIn);
/********** Generate list of Variable Names */ 
proc sql noprint;
    create table qx_0000_DDT as
    select name, label, format, 
        length(name) label='Length (Name)' as collen,
        /********** Useful flag (variable name > 8 char) */ 
        case
            when length(name)>8 then '>8' else '' 
        end label='Flag Name' as collen_,
 
        length(label) label='Length (Label)' as lablen,
        /********** Useful flag (label name > 40 char) */ 
        case
            when length(label)>40 then '>40' else '' 
        end label='Flag Label' as lablen_
    from dictionary.columns
    where libname='WORK' and upcase(MEMNAME)=upcase("&DBIN");
quit;

%put "NOTE: Number of Variables: &SQLOBS";

/********** Useful final Dataset with Column Number */ 
data qx_0000_DDT;
    format COLNR NAME LABEL FORMAT COLLEN COLLEN_ LABLEN LABLEN_;
    set qx_0000_DDT;
    COLNR=_N_;
    label COLNR="Column Number"; 
run;quit;
 
/********** Output to Log (vertically) */ 
data _NULL_;
    set qx_0000_DDT;
    put name;
run;quit;
 
/********** Output to Log (horizontally) */ 
proc sql noprint;
    select name into : COLNAMES separated by ' '
    from dictionary.columns
    where LIBNAME='WORK' and UPCASE(MEMNAME)=upcase("&DBIN");
quit;
%put &COLNAMES;
 
%mend colnames;

* Example:;
* %colnames(DM);
