defmodule TutorialUeberauthWeb.UserLoginLive do
  use TutorialUeberauthWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">
        Log in to account
        <:subtitle>
          Don't have an account?
          <.link navigate={~p"/users/register"} class="font-semibold text-brand hover:underline">
            Sign up
          </.link>
          for an account now.
        </:subtitle>
      </.header>

      <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
        <.input field={@form[:email]} type="email" label="Email" required />
        <.input field={@form[:password]} type="password" label="Password" required />

        <:actions>
          <.input field={@form[:remember_me]} type="checkbox" label="Keep me logged in" />
          <.link href={~p"/users/reset_password"} class="text-sm font-semibold">
            Forgot your password?
          </.link>
        </:actions>
        <:actions>
          <.button phx-disable-with="Logging in..." class="w-full">
            Log in <span aria-hidden="true">→</span>
          </.button>
        </:actions>
      </.simple_form>

      <%!-- Github の認証のリンクを追加 --%>
      <.link href={~p"/auth/github"} class="w-full ">Githubでログイン／登録</.link>

      <%!-- おまけ（よりそれっぽく） --%>
      <%!-- <div class="mt-6">
        <a href={~p"/auth/github"}
          class="w-full inline-flex items-center justify-center gap-2 px-4 py-2 border border-gray-300 rounded-md shadow-sm bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
          <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
            <path fill-rule="evenodd" clip-rule="evenodd"
              d="M12 .5C5.648.5.5 5.648.5 12c0 5.092 3.293 9.397 7.865 10.927.575.106.786-.25.786-.556 0-.274-.01-1.003-.016-1.969-3.2.696-3.878-1.54-3.878-1.54-.523-1.33-1.277-1.684-1.277-1.684-1.044-.714.08-.7.08-.7 1.155.082 1.763 1.186 1.763 1.186 1.026 1.757 2.693 1.25 3.348.956.105-.743.402-1.25.731-1.538-2.553-.29-5.238-1.277-5.238-5.685 0-1.255.448-2.282 1.183-3.086-.119-.29-.513-1.458.113-3.04 0 0 .967-.31 3.17 1.18a11.03 11.03 0 0 1 2.888-.388c.981.005 1.97.132 2.888.388 2.2-1.49 3.165-1.18 3.165-1.18.63 1.582.236 2.75.116 3.04.738.804 1.183 1.83 1.183 3.086 0 4.42-2.69 5.392-5.253 5.676.414.36.782 1.075.782 2.167 0 1.565-.015 2.826-.015 3.21 0 .31.208.67.79.556C20.71 21.392 24 17.088 24 12c0-6.352-5.148-11.5-12-11.5z" />
          </svg>
          Githubでログイン／登録
        </a>
      </div> --%>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
