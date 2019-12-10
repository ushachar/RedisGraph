/*
 * Copyright 2018-2019 Redis Labs Ltd. and Contributors
 *
 * This file is available under the Redis Labs Source Available License Agreement
 */

#pragma once

#include "../op.h"
#include "../op_argument.h"
#include "../../execution_plan.h"

/* SemiApply operation tests for the presence of a pattern
 * Normal Semi Apply: Starts by pulling on the main execution plan branch,
 * for each record received it tries to get a record from the match branch
 * if no data is produced it will try to fetch a new data point from the main execution plan branch,
 * otherwise the main execution plan branch record is passed onward.
 * Anti Semi Apply: Starts by pulling on the main execution plan branch,
 * for each record received it tries to get a record from the match branch
 * if no data is produced the main execution plan branch record is passed onward
 * otherwise it will try to fetch a new data point from the main execution plan branch. */

typedef struct OpSemiApply {
	OpBase op;
	Record r;               // Main execution plan branch record..
	Argument *op_arg;       // Match branch tap.
	OpBase *execution_plan_branch;  // Main execution plan branch root;
	OpBase *match_branch;           // Match branch root;
	Record r;                       // Main execution plan branch record.
	Argument *op_arg;               // Match branch tap.
} OpSemiApply;

OpBase *NewSemiApplyOp(ExecutionPlan *plan, bool anti);

/* Sets the main execution plan branch. In case this operation is called from ApplyMultiplexer operation
 * this branch will be an argument operation. */
void SemiApplyOp_SetExecutionPlanBranch(OpSemiApply *semi_apply_op, OpBase *execution_plan_root);

void SemiApplyOp_SetMatchBranch(OpSemiApply *semi_apply_op, OpBase *match_branch_root);
