#include "so_long.h"

static int	get_strlen(const char *s)
{
	int	len;

	len = 0;
	while (s[len] && s[len] != '\n')
		len++;
	return (len);
}

static void check_valid_characters(char *str, char *s)
{
	int		i;
	int 	len;

	i 	= 0;
	len = get_strlen(str);
	while (i < len)
	{
		if (!ft_strchr(s, str[i]))
			handle_error("Invalid Character!");
		i++;
	}
}

static void get_dimensions(int fd, t_map *map)
{
	char	*tmp;

	tmp = get_next_line(fd);
	map->width = get_strlen(tmp);
	map->height = 0;
	while (tmp)
	{
		check_valid_characters(tmp, "01CEP");
		if (map->width != get_strlen(tmp))
			handle_error("el mapap esta m4l");
		map->height++;
		tmp = get_next_line(fd);
	}
	if (map->height < 3 || map->width < 3)
		handle_error("el mapap esta m4l");
}

t_map	*get_map(int fd)
{
	t_map	*map;
	
	map = (t_map *)malloc(sizeof(t_map));
	if (!map)
		return (NULL);
	get_dimensions(fd, map);
	return (map);
}
