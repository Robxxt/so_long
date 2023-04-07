#ifndef SO_LONG_H
# define SO_LONG_H

#include "../lib/MLX42/include/MLX42/MLX42.h"
#include "../lib/libft/libft.h"
#include <fcntl.h>
#include <stdio.h>

typedef struct s_map
{
	char	**matrix;
	int		width;
	int 	height;
	int		p_row;
	int 	p_col;
	int		comestibles;
} t_map;

void	handle_error(char *str);
void	file_checker(char *filename);
t_map	*get_map(char *filename);

#endif