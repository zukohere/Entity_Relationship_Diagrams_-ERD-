-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "ProductType" (
    "TypeID" int   NOT NULL,
    "Type" string   NOT NULL,
    CONSTRAINT "pk_ProductType" PRIMARY KEY (
        "TypeID"
     ),
    CONSTRAINT "uc_ProductType_Type" UNIQUE (
        "Type"
    )
);

CREATE TABLE "Products" (
    "ProductID" int   NOT NULL,
    "ProductNum" string   NOT NULL,
    "ProductTypeID" int   NOT NULL,
    "ProductType" string   NOT NULL,
    "dateLaunch" date   NOT NULL,
    "dateObsolete" date   NOT NULL,
    CONSTRAINT "pk_Products" PRIMARY KEY (
        "ProductID"
     ),
    CONSTRAINT "uc_Products_ProductNum" UNIQUE (
        "ProductNum"
    )
);

CREATE TABLE "Issue" (
    "IssueID" int   NOT NULL,
    "ProductID" int   NOT NULL,
    "ProductNum" string   NOT NULL,
    "DateOpen" date   NOT NULL,
    "RaisedByID" int   NOT NULL,
    "RaisedBy" string   NOT NULL,
    -- how do you deal with lookups?
    "SeverityID" int   NOT NULL,
    "Severity" string   NOT NULL,
    "IssueTypeID" int   NOT NULL,
    "IssueType" string   NOT NULL,
    "IssueDesc" string   NOT NULL,
    "AssignToDeptID" int   NOT NULL,
    "AssignToDept" string   NOT NULL,
    -- Num of Actions for this issue
    "NumActions" count   NOT NULL,
    "DateClosed" date   NOT NULL,
    CONSTRAINT "pk_Issue" PRIMARY KEY (
        "IssueID"
     )
);

CREATE TABLE "Action_s" (
    "ActionID" int   NOT NULL,
    "IssueID" int   NOT NULL,
    -- Increments, Child of Issue
    "ActionNum" int   NOT NULL,
    "IssueSeverityID" int   NOT NULL,
    "IssueSeverity" int   NOT NULL,
    "DateOpen" date   NOT NULL,
    "ActTypeID" int   NOT NULL,
    "ActType" string   NOT NULL,
    "AssignToPersonID" int   NOT NULL,
    "AssignToPerson" string   NOT NULL,
    "ActionTaken" string   NOT NULL,
    "AccpetRejectID" int   NOT NULL,
    "AcceptReject" string   NOT NULL,
    "DateAcceptReject" date   NOT NULL,
    CONSTRAINT "pk_Action_s" PRIMARY KEY (
        "ActionID"
     )
);

CREATE TABLE "Decisions" (
    "DecisionID" int   NOT NULL,
    "Decision" string   NOT NULL,
    CONSTRAINT "pk_Decisions" PRIMARY KEY (
        "DecisionID"
     ),
    CONSTRAINT "uc_Decisions_Decision" UNIQUE (
        "Decision"
    )
);

CREATE TABLE "ActionType" (
    "ActionTypeID" int   NOT NULL,
    "ActionType" string   NOT NULL,
    CONSTRAINT "pk_ActionType" PRIMARY KEY (
        "ActionTypeID"
     ),
    CONSTRAINT "uc_ActionType_ActionType" UNIQUE (
        "ActionType"
    )
);

CREATE TABLE "People" (
    "EmpID" int   NOT NULL,
    "EmpName_first" string   NOT NULL,
    "EmpName_last" string   NOT NULL,
    CONSTRAINT "pk_People" PRIMARY KEY (
        "EmpID"
     )
);

CREATE TABLE "SeverityTypes" (
    "SeverityID" int   NOT NULL,
    "Severity" string   NOT NULL,
    CONSTRAINT "pk_SeverityTypes" PRIMARY KEY (
        "SeverityID"
     ),
    CONSTRAINT "uc_SeverityTypes_Severity" UNIQUE (
        "Severity"
    )
);

CREATE TABLE "Departments" (
    "DepartmentID" int   NOT NULL,
    "DepartmentName" string   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "DepartmentID"
     ),
    CONSTRAINT "uc_Departments_DepartmentName" UNIQUE (
        "DepartmentName"
    )
);

CREATE TABLE "IssueTypes" (
    "IssueTypeID" int   NOT NULL,
    "IssueType" string   NOT NULL,
    CONSTRAINT "pk_IssueTypes" PRIMARY KEY (
        "IssueTypeID"
     ),
    CONSTRAINT "uc_IssueTypes_IssueType" UNIQUE (
        "IssueType"
    )
);

ALTER TABLE "Products" ADD CONSTRAINT "fk_Products_ProductTypeID_ProductType" FOREIGN KEY("ProductTypeID", "ProductType")
REFERENCES "ProductType" ("TypeID", "Type");

ALTER TABLE "Issue" ADD CONSTRAINT "fk_Issue_ProductID_ProductNum" FOREIGN KEY("ProductID", "ProductNum")
REFERENCES "Products" ("ProductID", "ProductNum");

ALTER TABLE "Issue" ADD CONSTRAINT "fk_Issue_RaisedByID_RaisedBy" FOREIGN KEY("RaisedByID", "RaisedBy")
REFERENCES "People" ("EmpID", "EmpName_last");

ALTER TABLE "Issue" ADD CONSTRAINT "fk_Issue_SeverityID_Severity" FOREIGN KEY("SeverityID", "Severity")
REFERENCES "SeverityTypes" ("SeverityID", "Severity");

ALTER TABLE "Issue" ADD CONSTRAINT "fk_Issue_IssueTypeID_IssueType" FOREIGN KEY("IssueTypeID", "IssueType")
REFERENCES "IssueTypes" ("IssueTypeID", "IssueType");

ALTER TABLE "Issue" ADD CONSTRAINT "fk_Issue_AssignToDeptID_AssignToDept" FOREIGN KEY("AssignToDeptID", "AssignToDept")
REFERENCES "Departments" ("DepartmentID", "DepartmentName");

ALTER TABLE "Action_s" ADD CONSTRAINT "fk_Action_s_IssueID_IssueSeverityID_IssueSeverity" FOREIGN KEY("IssueID", "IssueSeverityID", "IssueSeverity")
REFERENCES "Issue" ("IssueID", "SeverityID", "Severity");

ALTER TABLE "Action_s" ADD CONSTRAINT "fk_Action_s_ActTypeID_ActType" FOREIGN KEY("ActTypeID", "ActType")
REFERENCES "ActionType" ("ActionTypeID", "ActionType");

ALTER TABLE "Action_s" ADD CONSTRAINT "fk_Action_s_AssignToPersonID_AssignToPerson" FOREIGN KEY("AssignToPersonID", "AssignToPerson")
REFERENCES "People" ("EmpID", "EmpName_last");

ALTER TABLE "Action_s" ADD CONSTRAINT "fk_Action_s_AccpetRejectID_AcceptReject" FOREIGN KEY("AccpetRejectID", "AcceptReject")
REFERENCES "Decisions" ("DecisionID", "Decision");

