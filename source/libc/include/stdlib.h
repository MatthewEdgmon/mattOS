/**
 * This file is part of mattOS.
 *
 * mattOS is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * mattOS is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with mattOS.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef __STDLIB_H__
#define __STDLIB_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Define NULL if it's undefined. */
#ifndef LIBC_NULL_DEFINED
#define LIBC_NULL_DEFINED
#ifdef __cplusplus
#define NULL 0L
#else
#define NULL ((void*)0)
#endif /* __cplusplus */
#endif /* LIBC_NULL_DEFINED */

#define EXIT_FAILURE 1
#define EXIT_SUCCESS 0

#define RAND_MAX (0x7FFFFFFF)

static unsigned long int rand_seed = 1;

/* Define size_t if it's undefined. */
#ifndef LIBC_SIZE_T_DEFINED
#define LIBC_SIZE_T_DEFINED
typedef unsigned long size_t;
#endif /* LIBC_SIZE_T_DEFINED */

#define EXIT_FAILURE 1
#define EXIT_SUCCESS 0

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* __STDLIB_H__ */