--TASK1
SELECT FIRST_NAME,
       LAST_NAME,
       HIRE_DATE,
       CASE 
           WHEN HIRE_DATE < TO_DATE('2003-01-01', 'YYYY-MM-DD') THEN 'Veteran'
           WHEN HIRE_DATE BETWEEN TO_DATE('2003-01-01', 'YYYY-MM-DD') AND TO_DATE('2006-12-31', 'YYYY-MM-DD') THEN 'Tecrubeli'
           WHEN HIRE_DATE >= TO_DATE('2007-01-01', 'YYYY-MM-DD') THEN 'Yeni'
       END AS STAJ_QRUPU
FROM HR.EMPLOYEES;

--TASK2
SELECT  DEPARTMENT_ID,DEPARTMENT_NAME,
    CASE DEPARTMENT_NAME 
        WHEN 'Administration' THEN 'Idareetme'
        WHEN 'Marketing' THEN 'Marketinq'
        WHEN 'Purchasing' THEN 'Satinalma'
        WHEN 'Human Resources' THEN 'Insan Resurslari'
        ELSE 'Diger sobe'
    END AS SOBE_AZ
FROM HR.DEPARTMENTS 

--TASK3
--CASE WHEN ILE
SELECT FIRST_NAME,DEPARTMENT_ID,
       CASE 
            WHEN DEPARTMENT_ID IS NULL THEN 'Sobe teyin olunmayib'
            WHEN DEPARTMENT_ID IS NOT NULL THEN 'Sobe var'
        END AS SOBE_STATUSU
FROM HR.EMPLOYEES;
--NVL2 ILE
SELECT FIRST_NAME,DEPARTMENT_ID,
NVL2(DEPARTMENT_ID,'Sobe var','Sobe teyin olunmayib') AS SOBE_STATUSU
FROM HR.EMPLOYEES;

--TASK4
SELECT JOB_ID,JOB_TITLE,
       CASE 
            WHEN JOB_ID IN ('AD_PRES','AD_VP','FI_MGR','AC_MGR') THEN 'Ali Rehberlik'
            WHEN JOB_ID IN ('IT_PROG','SA_REP','FI_ACCOUNT') THEN 'Esas Mutexessis'
            WHEN JOB_ID IN ('ST_CLERK', 'SH_CLERK', 'PU_CLERK') THEN 'Operativ Isci'
            ELSE 'Diger'
        END AS KATEQORIYA
FROM HR.JOBS;

--TASK5
SELECT FIRST_NAME,DEPARTMENT_ID,SALARY,
       CASE DEPARTMENT_ID 
            WHEN 50 THEN SALARY*0.08
            WHEN 30 THEN SALARY*0.12
            WHEN 100 THEN 400
            ELSE SALARY*0.04
        END AS MUAVINET
FROM HR.EMPLOYEES;

--TASK6
SELECT FIRST_NAME, COMMISSION_PCT,
       CASE
           WHEN COMMISSION_PCT IS NULL  THEN 'Yoxdur'
           WHEN COMMISSION_PCT > 0.25  THEN 'Yuksek komissiya'
           ELSE 'Normal komissiya'
       END AS "Komissiya novu"
FROM HR.EMPLOYEES;
-- = NULL yazmaq olmas is ve ya is not null yazmaq lazimdir 
-- >0.10 verende biz 0.5 versek birinci >0.1 u edecek ve cixacaq amma >0.25 i elemelidi ona gore sorqunu duzeldirik bele edirik 0.25>x>0.10
--biz else yerine 0 yazmali deyilik ve bizden 0.10 dan boyuk olduqda ne bas vereceyinide sorusmur ona gore onuda silirik
--end de tek dirnaq ile yazilib ama cut dirnaq ile yazilmaliydi

--TASK7
SELECT FIRST_NAME,PHONE_NUMBER,SALARY,
       CASE 
            WHEN PHONE_NUMBER LIKE '1.515%' THEN 'Daxili xett'
            WHEN SALARY>=10000 THEN 'Yuksek maasli'
            WHEN COMMISSION_PCT IS NOT NULL THEN 'Satis komandasi'
            ELSE 'Standart isci'
        END AS KATEQORIYA
FROM HR.EMPLOYEES;

--TASK8
SELECT FIRST_NAME,SALARY,COMMISSION_PCT,
NVL2(COMMISSION_PCT,SALARY * COMMISSION_PCT * 3,0) AS RUBLUK_BONUS,
NVL2(COMMISSION_PCT,SALARY*3+(SALARY * COMMISSION_PCT * 3),SALARY*3) AS RUBLUK_UMUMI
FROM HR.EMPLOYEES
ORDER BY RUBLUK_UMUMI ASC;

--TASK9
SELECT E.FIRST_NAME,J.JOB_TITLE,E.SALARY,J.MIN_SALARY,J.MAX_SALARY,
       CASE 
            WHEN SALARY = MAX_SALARY THEN 'Limite catib'
            WHEN MAX_SALARY - SALARY <= 2000 THEN 'Limite cox yaxin'
            WHEN SALARY < MIN_SALARY + 1000 THEN 'Baslangic seviyyede'
            ELSE 'Orta araliqda'
        END AS MAAS_VEZIYYETI
FROM HR.EMPLOYEES E
JOIN HR.JOBS J
ON E.JOB_ID=J.JOB_ID;
SELECT * FROM HR.LOCATIONS
--TASK10
SELECT E.FIRST_NAME,E.LAST_NAME,
       NVL2(D.MANAGER_ID,'Rehberi var','Rehbersiz sobe') AS MENECER_STATUSU,
       CASE 
            WHEN L.STATE_PROVINCE IS NULL THEN 'Teyin edilmeyib'
            WHEN L.COUNTRY_ID='US' THEN 'ABS ofisi'
            ELSE 'Beynelxalq ofis'
        END AS REGION
FROM HR.EMPLOYEES E
LEFT JOIN HR.DEPARTMENTS D
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
JOIN HR.LOCATIONS L
ON D.LOCATION_ID=L.LOCATION_ID

