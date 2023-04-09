NAME		:= so_long
MLXLIB		:= ./lib/MLX42
LIBFT		:= ./lib/libft
SRC			:=	src/so_long.c\
				src/file_checker.c\
				src/get_map.c\
				src/check_map.c\
				src/verify_valid_path.c\
				src/hooks.c\
				src/display_window.c\
				src/get_assets.c
OBJ			:= $(SRC:.c=.o)
CFLAGS		:= -Wall -Werror -Wextra
GLFWFLAGS	:= -framework Cocoa -framework OpenGL -framework IOKit
MLX_HEADER	:= -Iinclude -lglfw -L"/Users/rdragan/homebrew/Cellar/glfw/3.3.8/lib/"

all: $(MLXLIB) $(NAME) 

LSAN = LeakSanitizer
LSANLIB = /LeakSanitizer/liblsan.a
LSANLFLAGS := -LLeakSanitizer -llsan -lc++

lsan: CFLAGS += -ILeakSanitizer -Wno-gnu-include-next
lsan: LINK_FLAGS += $(LSANLFLAGS)
lsan: fclean $(LSANLIB)
lsan: all

$(LSAN):
	git clone https://github.com/mhahnFr/LeakSanitizer.git

$(LSANLIB): $(LSAN)
	$(MAKE) -C LeakSanitizer

$(NAME): build_mlx build_libft $(OBJ) $(LIBFT)
	@cc $(OBJ) $(LIBFT)/libft.a $(MLXLIB)/build/libmlx42.a $(LINK_FLAGS) $(MLX_HEADER) $(GLFWFLAGS) -o $(NAME)

$(LIBFT):
	echo HOLA
	@make -C $(LIBFT)

build_mlx:
	@cmake -S $(MLXLIB) -B $(MLXLIB)/build
	@make -C $(MLXLIB)/build
build_libft:
	@make -C $(LIBFT)

clean:
	@make -C $(LIBFT) clean
	@make -C $(MLXLIB)/build clean
	@rm -Rf $(OBJ)

fclean: clean
	@rm -Rf $(LIBFT)/libft.a
	@rm -f $(NAME)

re: fclean all


.PHONY: so_long, build_mlx, build_libft, all, clean, fclean, re